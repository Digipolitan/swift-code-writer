//
//  ProtocolDescription.swift
//  SwiftCodeWriter
//
//  Created by Benoit BRIATTE on 10/08/2017.
//

import Foundation

public struct ProtocolDescription: ModuleDependency {

    public struct Options {
        public let visibility: Visibility

        public init(visiblity: Visibility = .default) {
            self.visibility = visiblity
        }
    }

    public let name: String
    public let options: Options
    public var modules: [String]
    public var implements: [String]
    public var initializers: [InitializerDescription]
    public var methods: [MethodDescription]
    public var properties: [PropertyDescription]
    public var attributes: [String]
    public let documentation: String?

    public init(name: String, options: Options = Options(), modules: [String] = [], documentation: String? = nil) {
        self.name = name
        self.options = options
        self.modules = modules
        self.documentation = documentation
        self.implements = []
        self.initializers = []
        self.methods = []
        self.properties = []
        self.attributes = []
    }

    public func moduleDependencies() -> [String] {
        var dependencies: [ModuleDependency] = []
        dependencies += self.initializers as [ModuleDependency]
        dependencies += self.methods as [ModuleDependency]
        dependencies += self.properties as [ModuleDependency]
        return ProtocolDescription.union(modules: self.modules, with: dependencies)
    }
}
