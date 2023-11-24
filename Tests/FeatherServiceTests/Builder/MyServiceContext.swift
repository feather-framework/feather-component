//
//  MyServiceContext.swift
//  FeatherServiceTests
//
//  Created by Tibor Bödecs on 18/11/2023.
//

import FeatherService

struct MyServiceContext: ServiceContext {

    var foo: String

    func make() throws -> ServiceBuilder {
        MyServiceBuilder(context: self)
    }
}
