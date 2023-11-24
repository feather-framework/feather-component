//
//  ServiceRegistry.swift
//  FeatherService
//
//  Created by Tibor Bödecs on 18/11/2023.
//

import Logging

/// Service registry to handle individual services
///
/// This container provides a mechanism to store ``ServiceContext`` and
/// ``ServiceBuilder`` objects with a custom service id. On top of that it gives a frame
///  to log service events and control service lifecycles.
public final actor ServiceRegistry {

    private struct State {
        let id: any ServiceID
        let context: ServiceContext
        var builder: ServiceBuilder?
    }

    private var isInActiveState: Bool
    private var states: [String: State]
    private var logger: Logger
    
    /// Initializes the service registry
    ///
    /// - parameters:
    ///    - logger: Logger object with custom label
    public init(
        logger: Logger = .init(label: "service-registry")
    ) {
        self.isInActiveState = false
        self.states = [:]
        self.logger = logger
    }

    deinit {
        let exp = !isInActiveState
        assert(
            exp,
            "Service registry has active services, use shutdown before deinit."
        )
    }
}

/// manage all services at once
public extension ServiceRegistry {

    /// Gives back the service identifiers
    ///
    /// - returns: services identifiers
    func serviceIdentifiers() -> [any ServiceID] {
        states.keys.compactMap { states[$0]?.id }
    }

    /// Checks the service registry state
    ///
    /// - returns: True if any service is activated, False otherwise
    func isActive() -> Bool {
        for id in serviceIdentifiers() {
            if isActive(id) {
                return true
            }
        }
        return false
    }

    /// Starts the services
    func run() async throws {
        for id in serviceIdentifiers() {
            try await run(id)
        }
    }

    /// Shuts down the services
    func shutdown() async throws {
        for serviceId in serviceIdentifiers() {
            try shutdown(serviceId)
        }
    }
}

/// service state management
public extension ServiceRegistry {

    /// Checks if a service exists
    ///
    /// - parameters:
    ///    - id: Service identifier
    /// - returns: True if exists, false otherwise
    func exists(
        _ id: any ServiceID
    ) -> Bool {
        states[id.rawId] != nil
    }

    /// Adds a new service context
    ///
    /// - parameters:
    ///    - context: Service context object
    ///    - id: Service identifier
    func add(
        _ context: ServiceContext,
        id: any ServiceID
    ) async throws {
        try await remove(id)
        states[id.rawId] = .init(
            id: id,
            context: context
        )
    }

    /// Removes the service by id
    ///
    /// - parameters:
    ///    - id: Service identifier
    func remove(
        _ id: any ServiceID
    ) async throws {
        try shutdown(id)
        states[id.rawId] = nil
    }
}

/// service lifecycle management
public extension ServiceRegistry {

    /// Checks if a sercie activated or not
    ///
    /// - parameters:
    ///    - id: Service identifier
    /// - returns: True if the service is activated, False otherwise
    func isActive(
        _ id: any ServiceID
    ) -> Bool {
        if let state = states[id.rawId] {
            return state.builder != nil
        }
        return false
    }

    /// Starts an inactive service
    ///
    /// - parameters:
    ///    - id: Service identifier
    func run(
        _ id: any ServiceID
    ) async throws {
        guard let state = states[id.rawId], state.builder == nil else {
            return
        }
        states[id.rawId]!.builder = try state.context.make()
        isInActiveState = isActive()
    }

    /// Stops an active service
    ///
    /// - parameters:
    ///    - id: Service identifier
    func shutdown(
        _ id: any ServiceID
    ) throws {
        if let state = states[id.rawId] {
            try state.builder?.shutdown()
            states[id.rawId]!.builder = nil
        }
        self.isInActiveState = isActive()
    }

    /// Gets the service by id
    ///
    /// - parameters:
    ///    - id: Service identifier
    ///    - logger: Optional logger
    /// - returns: Service object if service exists, otherwise nil
    func get(
        _ id: any ServiceID,
        logger: Logger? = nil
    ) throws -> Service? {
        guard let state = states[id.rawId] else {
            return nil
        }
        let logger = logger ?? .init(label: id.rawId)

        let config = ServiceConfig(
            context: state.context,
            logger: logger
        )
        return try state.builder?.build(using: config)
    }
}
