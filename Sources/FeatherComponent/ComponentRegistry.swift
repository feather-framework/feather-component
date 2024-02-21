//
//  ComponentRegistry.swift
//  FeatherComponent
//
//  Created by Tibor Bödecs on 18/11/2023.
//

import Logging
import ServiceLifecycle

/// Component registry to handle individual components
///
/// This container provides a mechanism to store ``ComponentContext`` and
/// ``ComponentBuilder`` objects with a custom component id. On top of that it gives a frame
///  to log component events and control component lifecycles.
public final actor ComponentRegistry {

    private struct State {
        let id: any ComponentID
        let context: ComponentContext
        var builder: ComponentBuilder?
    }

    private var isInActiveState: Bool
    private var states: [String: State]
    private var logger: Logger

    /// Initializes the component registry
    ///
    /// - parameters:
    ///    - logger: Logger object with custom label
    public init(
        logger: Logger = .init(label: "component-registry")
    ) {
        self.isInActiveState = false
        self.states = [:]
        self.logger = logger
    }

    deinit {
        let exp = !isInActiveState
        assert(
            exp,
            "Component registry has active components, use shutdown before deinit."
        )
    }
}
extension ComponentRegistry: Service {

    /// Starts the components
    public func run() async throws {
        try await withGracefulShutdownHandler {
            for id in componentIdentifiers() {
                try await run(id)
            }
        } onGracefulShutdown: {
            Task {
                do {
                    try await self.shutdown()
                }
                catch {
                    await self.logger.error("Shutdown error: \(error)")
                }
            }
        }
    }
}
/// manage all components at once
public extension ComponentRegistry {

    /// Gives back the component identifiers
    ///
    /// - returns: components identifiers
    func componentIdentifiers() -> [any ComponentID] {
        states.keys.compactMap { states[$0]?.id }
    }

    /// Checks the component registry state
    ///
    /// - returns: True if any component is activated, False otherwise
    func isActive() -> Bool {
        for id in componentIdentifiers() {
            if isActive(id) {
                return true
            }
        }
        return false
    }

    /// Shuts down the components
    func shutdown() async throws {
        for componentId in componentIdentifiers() {
            try shutdown(componentId)
        }
    }
}

/// component state management
public extension ComponentRegistry {

    /// Checks if a component exists
    ///
    /// - parameters:
    ///    - id: Component identifier
    /// - returns: True if exists, false otherwise
    func exists(
        _ id: any ComponentID
    ) -> Bool {
        states[id.rawId] != nil
    }

    /// Adds a new component context
    ///
    /// - parameters:
    ///    - context: Component context object
    ///    - id: Component identifier
    func add(
        _ context: ComponentContext,
        id: any ComponentID
    ) async throws {
        try await remove(id)
        states[id.rawId] = .init(
            id: id,
            context: context
        )
    }

    /// Removes the component by id
    ///
    /// - parameters:
    ///    - id: Component identifier
    func remove(
        _ id: any ComponentID
    ) async throws {
        try shutdown(id)
        states[id.rawId] = nil
    }
}

/// component lifecycle management
public extension ComponentRegistry {

    /// Checks if a sercie activated or not
    ///
    /// - parameters:
    ///    - id: Component identifier
    /// - returns: True if the component is activated, False otherwise
    func isActive(
        _ id: any ComponentID
    ) -> Bool {
        if let state = states[id.rawId] {
            return state.builder != nil
        }
        return false
    }

    /// Starts an inactive component
    ///
    /// - parameters:
    ///    - id: Component identifier
    func run(
        _ id: any ComponentID
    ) async throws {
        guard let state = states[id.rawId], state.builder == nil else {
            return
        }
        states[id.rawId]!.builder = try state.context.make()
        isInActiveState = isActive()
    }

    /// Stops an active component
    ///
    /// - parameters:
    ///    - id: Component identifier
    func shutdown(
        _ id: any ComponentID
    ) throws {
        if let state = states[id.rawId] {
            try state.builder?.shutdown()
            states[id.rawId]!.builder = nil
        }
        isInActiveState = isActive()
    }

    /// Gets the component by id
    ///
    /// - parameters:
    ///    - id: Component identifier
    ///    - logger: Optional logger
    /// - returns: Component object if component exists, otherwise nil
    func get(
        _ id: any ComponentID,
        logger: Logger? = nil
    ) throws -> Component? {
        guard let state = states[id.rawId] else {
            return nil
        }
        let logger = logger ?? .init(label: id.rawId)

        let config = ComponentConfig(
            context: state.context,
            logger: logger
        )
        return try state.builder?.build(using: config)
    }
}
