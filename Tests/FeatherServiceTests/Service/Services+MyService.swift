//
//  Services+MyService.swift
//  FeatherServiceTests
//
//  Created by Tibor Bödecs on 20/11/2023.
//

import FeatherService
import Logging

public enum MyServiceID: ServiceID {

    case `default`
    case custom(String)

    public var rawId: String {
        switch self {
        case .default:
            return "my-service"
        case .custom(let value):
            return "my-service-\(value)"
        }
    }
}

public extension ServiceRegistry {

    func addMyService(
        _ context: ServiceContext,
        id: MyServiceID = .default
    ) async throws {
        try await add(context, id: id)
    }

    func myService(
        _ id: MyServiceID = .default,
        logger: Logger? = nil
    ) throws -> MyService {
        guard let storage = try get(id, logger: logger) as? MyService else {
            fatalError("My service not available, use `addMyService()` to register and `run()` before calling this function")
        }
        return storage
    }
}
