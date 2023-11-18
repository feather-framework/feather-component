//
//  MyServiceContext.swift
//  FeatherServiceTests
//
//  Created by Tibor Bodecs on 18/11/2023.
//

import FeatherService

struct MyServiceContext: ServiceContext {

    var foo: String

    func createDriver() throws -> ServiceDriver {
        MyServiceDriver()
    }
}
