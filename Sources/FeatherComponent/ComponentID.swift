//
//  ComponentID.swift
//  FeatherComponent
//
//  Created by Tibor Bödecs on 18/11/2023.
//

/// Component identifier.
public protocol ComponentID: Sendable, Hashable, Codable, Equatable {

    /// Raw component identifier.
    var rawId: String { get }
}
