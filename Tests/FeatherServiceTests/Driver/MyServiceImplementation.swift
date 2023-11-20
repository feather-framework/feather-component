//
//  MyServiceImplementation.swift
//  FeatherServiceTests
//
//  Created by Tibor Bödecs on 18/11/2023.
//

import FeatherService

struct MyServiceImplementation: MyService {

    var config: ServiceConfig

    func test() -> String {
        "test"
    }
}
