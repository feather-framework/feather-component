//
//  FeatherServiceTests.swift
//  FeatherServiceTests
//
//  Created by Tibor Bödecs on 2023. 01. 16..
//

import XCTest
import Logging
import FeatherService

final class FeatherServiceTests: XCTestCase {

    func testService() async throws {
        let registry = ServiceRegistry()

        try await registry.add(
            MyServiceContext(
                foo: "foo"
            )
        )

        try await registry.run()

        var logger = Logger(label: "my-logger")
        logger.logLevel = .trace

        let service = try await registry.myService()

        XCTAssertEqual(service.test(), "test")

        try await registry.shutdown()
    }
}
