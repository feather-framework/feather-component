//
//  MyComponentFactory.swift
//  FeatherComponentTests
//
//  Created by Tibor Bödecs on 18/11/2023.
//

import FeatherComponent

struct MyComponentFactory: ComponentFactory {

    /// NOTE: only add context if it is needed for custom init.
    let context: MyComponentContext

    func build(using config: ComponentConfig) throws -> Component {
        MyComponentImplementation(config: config)
    }
}
