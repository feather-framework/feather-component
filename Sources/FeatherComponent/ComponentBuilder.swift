//
//  ComponentBuilder.swift
//  FeatherComponent
//
//  Created by Tibor Bödecs on 18/11/2023.
//

/// Interface for custom component builders
public protocol ComponentBuilder {

    /// Builds the component builder
    ///
    /// - parameters:
    ///    - config: component configuration
    /// - returns: component
    func build(
        using config: ComponentConfig
    ) throws -> Component

    /// Shuts down the component builder
    func shutdown() throws
}

public extension ComponentBuilder {

    func shutdown() throws {}
}
