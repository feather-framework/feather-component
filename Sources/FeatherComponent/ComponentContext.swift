//
//  ComponentContext.swift
//  FeatherComponent
//
//  Created by Tibor Bödecs on 18/11/2023.
//

/// Interface for custom component contexts
public protocol ComponentContext: Sendable {

    /// Makes a new ``ComponentBuilder`` object
    ///
    /// - returns: new ``ComponentBuilder`` object
    func make() throws -> ComponentBuilder
}
