//
//  MyComponentImplementation.swift
//  FeatherComponentTests
//
//  Created by Tibor Bödecs on 18/11/2023.
//

import FeatherComponent

struct MyComponentImplementation: MyComponent {

    var config: ComponentConfig

    func test() -> String {
        "test"
    }
}
