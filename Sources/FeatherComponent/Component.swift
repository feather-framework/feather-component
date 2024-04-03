//
//  Component.swift
//  FeatherComponent
//
//  Created by Tibor Bödecs on 18/11/2023.
//

import Logging

/// Interface for custom components.
public protocol Component: Sendable {

    /// Component configuration.
    var config: ComponentConfig { get }
}

/// Logger related extension.
extension Component {

    /// Component logger.
    public var logger: Logger { config.logger }
}
