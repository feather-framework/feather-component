//
//  ComponentRegistry.swift
//  FeatherComponent
//
//  Created by Tibor Bödecs on 18/11/2023.
//

import Logging

/// Component registry to handle individual components.
///
/// This container provides a mechanism to store ``ComponentContext`` and
/// ``ComponentFactory`` objects with a custom component id. On top of that it gives a frame
///  to log component events and control component lifecycles.
public final actor ComponentRegistry {

    private struct State {
        let id: any ComponentID
        let context: ComponentContext
        var builder: ComponentFactory?
    }

    private var isInActiveState: Bool
    private var states: [String: State]
    private var logger: Logger

    /// Initializes the component registry.
    ///
    /// - parameter:
    ///    - logger: Logger object with custom label
    public init(
        logger: Logger = .init(label: "component-registry")
    ) {
        self.isInActiveState = false
        self.states = [:]
        self.logger = logger
    }
}

/// Component state management.
extension ComponentRegistry {

    /// Gives back the component identifiers.
    ///
    /// - returns: components identifiers
    public func componentIdentifiers() -> [any ComponentID] {
        states.keys.compactMap { states[$0]?.id }
    }

    /// Checks if a component exists.
    ///
    /// - parameter:
    ///    - id: Component identifier
    /// - returns: True if exists, false otherwise
    public func exists(
        _ id: any ComponentID
    ) -> Bool {
        states[id.rawId] != nil
    }

    /// Adds a new component context.
    ///
    /// - parameter:
    ///    - context: Component context object
    ///    - id: Component identifier
    public func add(
        _ context: ComponentContext,
        id: any ComponentID
    ) async throws {
        try await remove(id)
        states[id.rawId] = .init(
            id: id,
            context: context
        )
    }

    /// Removes the component by id.
    ///
    /// - parameter:
    ///    - id: Component identifier
    public func remove(
        _ id: any ComponentID
    ) async throws {
        states[id.rawId] = nil
    }
}

/// component lifecycle management
extension ComponentRegistry {

    /// Gets the component by id.
    ///
    /// - parameter:
    ///    - id: Component identifier
    ///    - logger: Optional logger
    /// - returns: Component object if component exists, otherwise nil
    public func get(
        _ id: any ComponentID,
        logger: Logger? = nil
    ) throws -> Component? {
        if let state = states[id.rawId], state.builder == nil {
            states[id.rawId]!.builder = try state.context.make()
        }
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
