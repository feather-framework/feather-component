//
//  ServiceBuilder.swift
//  FeatherService
//
//  Created by Tibor Bödecs on 18/11/2023.
//

/// Interface for custom service builders
public protocol ServiceBuilder {

    /// Builds the service builder
    ///
    /// - parameters:
    ///    - config: service configuration
    /// - returns: service
    func build(
        using config: ServiceConfig
    ) throws -> Service

    /// Shuts down the service builder
    func shutdown() throws
}

public extension ServiceBuilder {

    func shutdown() throws {}
}
