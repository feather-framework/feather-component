//
//  ComponentConfig.swift
//  FeatherComponent
//
//  Created by Tibor Bödecs on 18/11/2023.
//

import Logging

/// Component configartion
public struct ComponentConfig: Sendable {

    /// Reference to the ``ComponentContext`` object
    public let context: ComponentContext
    let logger: Logger
    
    init(
        context: ComponentContext,
        logger: Logger
    ) {
        self.context = context
        self.logger = logger
    }
}
