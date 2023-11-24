//
//  MyServiceBuilder.swift
//  FeatherServiceTests
//
//  Created by Tibor Bödecs on 18/11/2023.
//

import FeatherService

struct MyServiceBuilder: ServiceBuilder {

    /// NOTE: only add context if it is needed for shutdown or init
    let context: MyServiceContext

    init(context: MyServiceContext) {
        self.context = context
    }

    func build(using config: ServiceConfig) throws -> Service {
        MyServiceImplementation(config: config)
    }

    func shutdown() throws {
        print("shutdown:", context.foo)
    }
}
