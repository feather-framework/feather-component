//
//  ServiceConfig.swift
//  FeatherService
//
//  Created by Tibor Bodecs on 18/11/2023.
//

import Logging

public struct ServiceConfig: Sendable {

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
