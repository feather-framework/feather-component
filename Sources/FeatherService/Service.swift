//
//  Service.swift
//  FeatherService
//
//  Created by Tibor Bödecs on 18/11/2023.
//

import Logging

public protocol Service: Sendable {

    var config: ServiceConfig { get }
}

public extension Service {

    var logger: Logger { config.logger }
}
