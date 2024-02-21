//
//  FeatherComponentTests.swift
//  FeatherComponentTests
//
//  Created by Tibor Bödecs on 2023. 01. 16..
//

import XCTest
import Logging
import FeatherComponent

final class FeatherComponentTests: XCTestCase {

    func testComponentShutdown() async throws {
        let registry = ComponentRegistry()

        try await registry.addMyComponent(
            MyComponentContext(
                foo: "foo"
            )
        )

        try await registry.run()
        
        let isActive = await registry.isActive(MyComponentID.default)
        XCTAssertTrue(isActive)
        let isRegistryActive = await registry.isActive()
        XCTAssertTrue(isRegistryActive)

        var logger = Logger(label: "my-logger")
        logger.logLevel = .trace
        
        let component = try await registry.myComponent()
        
        XCTAssertEqual(component.test(), "test")

        try await registry.shutdown()
    }
    
    func testComponentRegistry() async throws {
        let registry = ComponentRegistry()

        try await registry.run()

        try await registry.addMyComponent(
            MyComponentContext(
                foo: "foo"
            )
        )
        let isActive = await registry.isActive(MyComponentID.default)
        XCTAssertFalse(isActive)
        let isRegistryActive = await registry.isActive()
        XCTAssertFalse(isRegistryActive)
        
        let ids = await registry.componentIdentifiers()
        XCTAssertEqual(ids.count, 1)
        
        guard let componentId = ids[0] as? MyComponentID else {
            return XCTFail("Component id should be MyComponentID")
        }
        XCTAssertEqual(componentId, .default)
    }
}
