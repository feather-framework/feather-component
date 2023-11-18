//
//  ServiceID.swift
//  FeatherService
//
//  Created by Tibor Bodecs on 18/11/2023.
//

/// service identifier
public struct ServiceID: Sendable, Hashable, Codable, Equatable {

    /// string representation of the identifier
    public let rawValue: String

    /// create a service identifier
    public init(_ rawValue: String) {
        self.rawValue = rawValue
    }
}

extension ServiceID: ExpressibleByStringLiteral {

    public init(stringLiteral value: StringLiteralType) {
        self.rawValue = value
    }
}
