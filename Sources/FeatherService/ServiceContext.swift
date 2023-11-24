//
//  ServiceContext.swift
//  FeatherService
//
//  Created by Tibor Bödecs on 18/11/2023.
//

/// Interface for custom service contexts
public protocol ServiceContext: Sendable {

    /// Makes a new ``ServiceBuilder`` object
    ///
    /// - returns: new ``ServiceBuilder`` object
    func make() throws -> ServiceBuilder
}
