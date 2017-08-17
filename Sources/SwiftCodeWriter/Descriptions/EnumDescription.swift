//
//  EnumDescription.swift
//  SwiftCodeWriter
//
//  Created by Benoit BRIATTE on 09/08/2017.
//

import Foundation

public struct EnumDescription: ModuleDependency {

    public struct Options {
        public let visibility: Visibility
        public let isIndirect: Bool

        public init(visibility: Visibility = .default, isIndirect: Bool = false) {
            self.visibility = visibility
            self.isIndirect = isIndirect
        }
    }

    public struct Case {
        public let name: String
        public let rawValue: String?
        public let associatedValues: [String]?
        public var modules: [String]
        public let isIndirect: Bool

        public init(name: String, rawValue: String? = nil, associatedValues: [String]? = nil, modules: [String] = [], isIndirect: Bool = false) {
            self.name = name
            self.rawValue = rawValue
            self.associatedValues = associatedValues
            self.isIndirect = isIndirect
            self.modules = modules
        }
    }

    public let name: String
    public let options: Options
    public let rawType: String?
    public var cases: [Case]
    public var implements: [String]
    public var modules: [String]
    public var initializers: [InitializerDescription]
    public var methods: [MethodDescription]
    public var properties: [PropertyDescription]
    public var nestedClasses: [ClassDescription]
    public var nestedEnums: [EnumDescription]
    public var attributes: [String]
    public let documentation: String?

    public init(name: String, options: Options = Options(), rawType: String? = nil, modules: [String] = [], documentation: String? = nil) {
        self.name = name
        self.options = options
        self.rawType = rawType
        self.modules = modules
        self.documentation = documentation
        self.cases = []
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
        var modules = self.modules
        self.cases.forEach { modules += $0.modules }
        return EnumDescription.union(modules: modules, with: dependencies)
    }
}

