//
//  ServiceContextFactory.swift
//  FeatherService
//
//  Created by Tibor Bodecs on 18/11/2023.
//

public struct ServiceContextFactory {

    let build: () throws -> ServiceContext

    public init(
        _ build: @escaping () throws -> ServiceContext
    ) {
        self.build = build
    }
}
