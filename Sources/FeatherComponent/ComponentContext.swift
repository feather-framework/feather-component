//
//  ComponentContext.swift
//  FeatherComponent
//
//  Created by Tibor Bödecs on 18/11/2023.
//

/// Interface for custom component contexts.
public protocol ComponentContext: Sendable {

    /// Makes a new ``ComponentFactory`` object.
    ///
    /// - returns: new ``ComponentFactory`` object
    func make() throws -> ComponentFactory
}
