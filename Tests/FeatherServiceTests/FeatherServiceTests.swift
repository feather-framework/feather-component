//
//  FeatherServiceTests.swift
//  FeatherServiceTests
//
//  Created by Tibor Bodecs on 2023. 01. 16..
//

import XCTest
import Logging
import FeatherService

final class FeatherServiceTests: XCTestCase {

    func testService() async throws {
        let registry = ServiceRegistry()

        try await registry.add(
            .myService(
                foo: "foo"
            ),
            as: .myService
        )

        try await registry.run(.myService)

        var logger = Logger(label: "my-logger")
        logger.logLevel = .trace

        let service =
            try await registry.get(.myService, logger: logger)
            as? MyServiceProtocol

        XCTAssertEqual(service?.test(), "test")

        try await registry.shutdown(.myService)
        try await registry.shutdown()
    }
    
    func testServiceIDs() {
        let serviceID1 = ServiceID("foo")
        let serviceID2 = ServiceID(stringLiteral: "bar")
        let serviceID3: ServiceID = "baz"
        
        XCTAssertEqual(serviceID1.rawValue, "foo")
        XCTAssertEqual(serviceID2.rawValue, "bar")
        XCTAssertEqual(serviceID3.rawValue, "baz")
    }
}
