//
//  ServiceContext.swift
//  FeatherService
//
//  Created by Tibor Bödecs on 18/11/2023.
//

public protocol ServiceContext: Sendable {

    func createDriver() throws -> ServiceDriver
}
