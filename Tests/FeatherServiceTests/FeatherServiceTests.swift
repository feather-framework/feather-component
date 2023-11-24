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

        try await registry.addMyService(
            MyServiceContext(
                foo: "foo"
            )
        )

        try await registry.run()
        
        let isActive = await registry.isActive(MyServiceID.default)
        XCTAssertTrue(isActive)
        let isRegistryActive = await registry.isActive()
        XCTAssertTrue(isRegistryActive)

        var logger = Logger(label: "my-logger")
        logger.logLevel = .trace
        
        let service = try await registry.myService()
        
        XCTAssertEqual(service.test(), "test")

        try await registry.shutdown()
    }
    
    func testService2() async throws {
        let registry = ServiceRegistry()

        try await registry.run()

        try await registry.addMyService(
            MyServiceContext(
                foo: "foo"
            )
        )
        let isActive = await registry.isActive(MyServiceID.default)
        XCTAssertFalse(isActive)
        let isRegistryActive = await registry.isActive()
        XCTAssertFalse(isRegistryActive)
        
        let ids = await registry.serviceIdentifiers()
        XCTAssertEqual(ids.count, 1)
        
        guard let serviceId = ids[0] as? MyServiceID else {
            return XCTFail("Service id should be MyServiceID")
        }
        XCTAssertEqual(serviceId, .default)
    }
}
