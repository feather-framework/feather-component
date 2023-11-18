//
//  MyService.swift
//  FeatherServiceTests
//
//  Created by Tibor Bodecs on 18/11/2023.
//

import FeatherService

struct MyService: MyServiceProtocol {

    var config: ServiceConfig

    func test() -> String{
        "test"
    }
}
