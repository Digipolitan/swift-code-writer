//
//  FileDescription.swift
//  SwiftCodeWriter
//
//  Created by Benoit BRIATTE on 10/08/2017.
//

import Foundation

public struct FileDescription: ModuleDependency {

    public var classes: [ClassDescription]
    public var enums: [EnumDescription]
    public var protocols: [ProtocolDescription]
    public var extensions: [ExtensionDescription]
    public var methods: [MethodDescription]
    public var properties: [PropertyDescription]
    public let documentation: String?

    public init(documentation: String? = nil) {
        self.documentation = documentation
        self.classes = []
        self.enums = []
        self.protocols = []
        self.extensions = []
        self.methods = []
        self.properties = []
    }

    public func moduleDependencies() -> [String] {
        var dependencies: [ModuleDependency] = []
        dependencies += self.classes as [ModuleDependency]
        dependencies += self.enums as [ModuleDependency]
        dependencies += self.protocols as [ModuleDependency]
        dependencies += self.extensions as [ModuleDependency]
        dependencies += self.methods as [ModuleDependency]
        dependencies += self.properties as [ModuleDependency]
        return FileDescription.union(modules: [], with: dependencies)
    }
}
