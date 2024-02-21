//
//  Components+MyComponent.swift
//  FeatherComponentTests
//
//  Created by Tibor Bödecs on 20/11/2023.
//

import FeatherComponent
import Logging

public enum MyComponentID: ComponentID {

    case `default`
    case custom(String)

    public var rawId: String {
        switch self {
        case .default:
            return "my-component"
        case .custom(let value):
            return "my-component-\(value)"
        }
    }
}

public extension ComponentRegistry {

    func addMyComponent(
        _ context: ComponentContext,
        id: MyComponentID = .default
    ) async throws {
        try await add(context, id: id)
    }

    func myComponent(
        _ id: MyComponentID = .default,
        logger: Logger? = nil
    ) throws -> MyComponent {
        guard let storage = try get(id, logger: logger) as? MyComponent else {
            fatalError(
                "My component not available, use `addMyComponent()` to register and `run()` before calling this function"
            )
        }
        return storage
    }
}
