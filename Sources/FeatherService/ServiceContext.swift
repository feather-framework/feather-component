//
//  ServiceContext.swift
//  FeatherService
//
//  Created by Tibor Bodecs on 18/11/2023.
//

public protocol ServiceContext: Sendable {

    func createDriver() throws -> ServiceDriver
}
