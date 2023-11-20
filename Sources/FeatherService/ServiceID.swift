//
//  ServiceID.swift
//  FeatherService
//
//  Created by Tibor Bödecs on 18/11/2023.
//

/// service identifier
public protocol ServiceID: Sendable, Hashable, Codable, Equatable {

    var rawId: String { get }
}
