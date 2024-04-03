//
//  ComponentFactory.swift
//  FeatherComponent
//
//  Created by Tibor Bödecs on 18/11/2023.
//

/// Interface for custom component builders.
public protocol ComponentFactory {

    /// Builds the component.
    ///
    /// - parameter:
    ///    - config: component configuration
    /// - returns: component
    func build(
        using config: ComponentConfig
    ) throws -> Component
}
