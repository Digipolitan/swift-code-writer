//
//  ExtensionDescription.swift
//  SwiftCodeWriter
//
//  Created by Benoit BRIATTE on 10/08/2017.
//

import Foundation

public struct ExtensionDescription: ModuleDependency {

    public struct Options {
        public let visibility: Visibility

        public init(visibility: Visibility = .default) {
            self.visibility = visibility
        }
    }

    public let target: String
    public let options: Options
    public var modules: [String]
    public var implements: [String]
    public var initializers: [InitializerDescription]
    public var methods: [MethodDescription]
    public var properties: [PropertyDescription]
    public var nestedClasses: [ClassDescription]
    public var nestedEnums: [EnumDescription]
    public var attributes: [String]
    public let documentation: String?

    public init(target: String, options: Options = Options(), modules: [String] = [], documentation: String? = nil) {
        self.target = target
        self.options = options
        self.modules = modules
        self.documentation = documentation
        self.implements = []
        self.initializers = []
        self.methods = []
        self.properties = []
        self.nestedClasses = []
        self.nestedEnums = []
        self.attributes = []
    }

    public func moduleDependencies() -> [String] {
        var dependencies: [ModuleDependency] = []
        dependencies += self.initializers as [ModuleDependency]
        dependencies += self.methods as [ModuleDependency]
        dependencies += self.properties as [ModuleDependency]
        dependencies += self.nestedClasses as [ModuleDependency]
        dependencies += self.nestedEnums as [ModuleDependency]
        return ExtensionDescription.union(modules: self.modules, with: dependencies)
    }
}
