//
//  ServiceID.swift
//  FeatherService
//
//  Created by Tibor Bödecs on 18/11/2023.
//

/// Service identifier
public protocol ServiceID: Sendable, Hashable, Codable, Equatable {

    /// Raw service identifier
    var rawId: String { get }
}
