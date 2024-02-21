//
//  MyComponentContext.swift
//  FeatherComponentTests
//
//  Created by Tibor Bödecs on 18/11/2023.
//

import FeatherComponent

struct MyComponentContext: ComponentContext {

    var foo: String

    func make() throws -> ComponentBuilder {
        MyComponentBuilder(context: self)
    }
}
