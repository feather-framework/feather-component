//
//  MyComponentBuilder.swift
//  FeatherComponentTests
//
//  Created by Tibor Bödecs on 18/11/2023.
//

import FeatherComponent

struct MyComponentBuilder: ComponentBuilder {

    /// NOTE: only add context if it is needed for shutdown or init
    let context: MyComponentContext

    init(context: MyComponentContext) {
        self.context = context
    }

    func build(using config: ComponentConfig) throws -> Component {
        MyComponentImplementation(config: config)
    }

    func shutdown() throws {
        print("shutdown:", context.foo)
    }
}
