//
//  MyServiceDriver.swift
//  FeatherServiceTests
//
//  Created by Tibor Bodecs on 18/11/2023.
//

import FeatherService

struct MyServiceDriver: ServiceDriver {

    func run(using config: ServiceConfig) throws -> Service {
        MyService(config: config)
    }

    func shutdown() throws {
        print("shutdown")
    }
}
