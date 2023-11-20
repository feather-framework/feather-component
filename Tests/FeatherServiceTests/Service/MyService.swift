//
//  MyServiceProtocol.swift
//  FeatherServiceTests
//
//  Created by Tibor Bödecs on 18/11/2023.
//

import FeatherService

public protocol MyService: Service {

    func test() -> String
}
