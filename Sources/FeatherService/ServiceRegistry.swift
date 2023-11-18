//
//  ServiceRegistry.swift
//  FeatherService
//
//  Created by Tibor Bodecs on 18/11/2023.
//

import Logging

public final actor ServiceRegistry {

    private struct State {
        let id: ServiceID
        let context: ServiceContext
        var driver: ServiceDriver?
    }

    private var isInActiveState: Bool
    private var states: [ServiceID: State]
    private var logger: Logger

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

    func serviceIdentifiers() -> Set<ServiceID> {
        .init(states.keys)
    }

    func isActive() -> Bool {
        for id in serviceIdentifiers() {
            if isActive(id) {
                return true
            }
        }
        return false
    }

    func run() async throws {
        for id in serviceIdentifiers() {
            try await run(id)
        }
    }

    func shutdown() async throws {
        for serviceId in serviceIdentifiers() {
            try shutdown(serviceId)
        }
    }
}

/// service state management
public extension ServiceRegistry {

    /// check if a service exists
    func exists(
        _ id: ServiceID
    ) -> Bool {
        states[id] != nil
    }

    /// add a service, if exists, it'll shutdown and remove old one
    func add(
        _ contextFactory: ServiceContextFactory,
        as id: ServiceID
    ) async throws {
        try remove(id)
        states[id] = .init(
            id: id,
            context: try contextFactory.build()
        )
    }

    /// remove a service, also shutdown before remove
    func remove(
        _ id: ServiceID
    ) throws {
        try shutdown(id)
        states[id] = nil
    }
}

/// service lifecycle management
public extension ServiceRegistry {

    /// check if a service is active or not
    func isActive(
        _ id: ServiceID
    ) -> Bool {
        if let state = states[id] {
            return state.driver != nil
        }
        return false
    }

    /// start an inactive service
    func run(
        _ id: ServiceID
    ) async throws {
        guard let state = states[id], state.driver == nil else {
            return
        }
        states[id]!.driver = try state.context.createDriver()
        isInActiveState = isActive()
    }

    /// stop an active service
    func shutdown(
        _ id: ServiceID
    ) throws {
        if let state = states[id] {
            try state.driver?.shutdown()
            states[id]!.driver = nil
        }
        self.isInActiveState = isActive()
    }

    /// returns the service if it's active
    func get(
        _ id: ServiceID,
        logger: Logger? = nil
    ) throws -> Service? {
        guard let state = states[id] else {
            return nil
        }
        let logger = logger ?? .init(label: id.rawValue)
        //        logger[metadataKey: "service-id"] = .string(id.string)

        let config = ServiceConfig(
            context: state.context,
            logger: logger
        )
        return try state.driver?.run(using: config)
    }

}
