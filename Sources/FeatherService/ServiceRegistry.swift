//
//  ServiceRegistry.swift
//  FeatherService
//
//  Created by Tibor Bödecs on 18/11/2023.
//

import Logging

public final actor ServiceRegistry {

    private struct State {
        let id: any ServiceID
        let context: ServiceContext
        var driver: ServiceDriver?
    }

    private var isInActiveState: Bool
    private var states: [String: State]
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

    func serviceIdentifiers() -> [any ServiceID] {
        states.keys.compactMap { states[$0]?.id }
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
        _ id: any ServiceID
    ) -> Bool {
        states[id.rawId] != nil
    }

    /// add a service, if exists, it'll shutdown and remove old one
    func add(
        _ contextWrapper: ServiceContextWrapper,
        id: any ServiceID
    ) async throws {
        try await remove(id)
        states[id.rawId] = .init(
            id: id,
            context: try contextWrapper.unwrap()
        )
    }

    /// remove a service, also shutdown before remove
    func remove(
        _ id: any ServiceID
    ) async throws {
        try shutdown(id)
        states[id.rawId] = nil
    }
}

/// service lifecycle management
public extension ServiceRegistry {

    /// check if a service is active or not
    func isActive(
        _ id: any ServiceID
    ) -> Bool {
        if let state = states[id.rawId] {
            return state.driver != nil
        }
        return false
    }

    /// start an inactive service
    func run(
        _ id: any ServiceID
    ) async throws {
        guard let state = states[id.rawId], state.driver == nil else {
            return
        }
        states[id.rawId]!.driver = try state.context.createDriver()
        isInActiveState = isActive()
    }

    /// stop an active service
    func shutdown(
        _ id: any ServiceID
    ) throws {
        if let state = states[id.rawId] {
            try state.driver?.shutdown()
            states[id.rawId]!.driver = nil
        }
        self.isInActiveState = isActive()
    }

    /// returns the service if it's active
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
        return try state.driver?.run(using: config)
    }

}
