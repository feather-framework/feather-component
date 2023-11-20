//
//  ServiceContextFactory.swift
//  FeatherService
//
//  Created by Tibor Bödecs on 18/11/2023.
//

public struct ServiceContextWrapper {

    let unwrap: () throws -> ServiceContext

    public init(
        _ unwrap: @escaping () throws -> ServiceContext
    ) {
        self.unwrap = unwrap
    }
}
