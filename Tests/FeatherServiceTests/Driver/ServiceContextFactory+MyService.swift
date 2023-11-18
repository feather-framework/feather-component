//
//  ServiceContextFactory+MyService.swift
//  FeatherServiceTests
//
//  Created by Tibor Bodecs on 18/11/2023.
//

import FeatherService

extension ServiceContextFactory {

    static func myService(
        foo: String
    ) -> Self {
        .init {
            MyServiceContext(
                foo: foo
            )
        }
    }
}
