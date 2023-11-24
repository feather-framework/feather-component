//
//  ServiceConfig.swift
//  FeatherService
//
//  Created by Tibor Bödecs on 18/11/2023.
//

import Logging

/// Service configartion
public struct ServiceConfig: Sendable {

    /// Reference to the ``ServiceContext`` object
    public let context: ServiceContext
    let logger: Logger
    
    init(
        context: ServiceContext,
        logger: Logger
    ) {
        self.context = context
        self.logger = logger
    }
}
