//
//  ClassDescription.swift
//  SwiftCodeWriter
//
//  Created by Benoit BRIATTE on 09/08/2017.
//

import Foundation

public struct ClassDescription: ModuleDependency {

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
    public var nestedEnums: [EnumDescription]
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
        return ClassDescription.union(modules: self.modules, with: dependencies)
    }
}
