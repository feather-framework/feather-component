//
//  ServiceDriver.swift
//  FeatherService
//
//  Created by Tibor Bodecs on 18/11/2023.
//

/// service driver
public protocol ServiceDriver {

    /// create a service instance using the config
    func run(
        using config: ServiceConfig
    ) throws -> Service

    /// driver shutdown function
    func shutdown() throws
}

public extension ServiceDriver {

    func shutdown() throws {}
}
