//
//  ClassDescription.swift
//  SwiftCodeWriter
//
//  Created by Benoit BRIATTE on 09/08/2017.
//

import Foundation

public struct ClassDescription {

    public struct Options {
        public let visibility: Visibility
        public let isReferenceType: Bool

        public init(visibility: Visibility = .default, isReferenceType: Bool = true) {
            self.visibility = visibility
            self.isReferenceType = isReferenceType
        }
    }

    public let name: String
    public let options: Options
    public let parent: String?
    public var implements: [String]
    public var modules: [String]
    public var initializers: [InitializerDescription]
    public var methods: [MethodDescription]
    public var properties: [PropertyDescription]
    public var nestedClasses: [ClassDescription]
    public var attributes: [String]
    public let documentation: String?

    public init(name: String, options: Options = Options(), parent: String? = nil, modules: [String] = [], documentation: String? = nil) {
        self.name = name
        self.options = options
        self.parent = parent
        self.modules = modules
        self.documentation = documentation
        self.implements = []
        self.initializers = []
        self.methods = []
        self.properties = []
        self.nestedClasses = []
        self.attributes = []
    }

    public func moduleDependencies() -> [String] {
        var modules = Set<String>()
        modules.formUnion(self.modules)
        for nested in self.nestedClasses {
            modules.formUnion(nested.moduleDependencies())
        }
        for initializer in self.initializers {
            modules.formUnion(initializer.modules)
        }
        for method in self.methods {
            modules.formUnion(method.modules)
        }
        for property in self.properties {
            if let module = property.module {
                modules.insert(module)
            }
        }
        return Array(modules)
    }
}
