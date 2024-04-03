//
//  FeatherComponentTests.swift
//  FeatherComponentTests
//
//  Created by Tibor Bödecs on 2023. 01. 16..
//

import FeatherComponent
import Logging
import XCTest

final class FeatherComponentTests: XCTestCase {

    func testComponent() async throws {
        let registry = ComponentRegistry()

        try await registry.addMyComponent(
            MyComponentContext(
                foo: "foo"
            )
        )

        let exists = await registry.exists(MyComponentID.default)
        XCTAssertTrue(exists)

        var logger = Logger(label: "my-logger")
        logger.logLevel = .trace

        let component = try await registry.myComponent()

        XCTAssertEqual(component.test(), "test")

    }

    func testComponentRegistry() async throws {
        let registry = ComponentRegistry()

        try await registry.addMyComponent(
            MyComponentContext(
                foo: "foo"
            )
        )

        let exists = await registry.exists(MyComponentID.default)
        XCTAssertTrue(exists)

        let ids = await registry.componentIdentifiers()
        XCTAssertEqual(ids.count, 1)

        guard let componentId = ids[0] as? MyComponentID else {
            return XCTFail("Component id should be MyComponentID")
        }
        XCTAssertEqual(componentId, .default)
    }

    func testNonExistingComponent() async throws {
        let registry = ComponentRegistry()

        let exists = await registry.exists(MyComponentID.default)
        XCTAssertFalse(exists)
    }
}
