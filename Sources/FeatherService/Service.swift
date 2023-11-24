//
//  Service.swift
//  FeatherService
//
//  Created by Tibor Bödecs on 18/11/2023.
//

import Logging

/// Interface for custom services
public protocol Service: Sendable {

    /// Service configuration
    var config: ServiceConfig { get }
}

public extension Service {

    /// Service logger
    var logger: Logger { config.logger }
}
