//
//  PropertyDescription.swift
//  SwiftCodeWriter
//
//  Created by Benoit BRIATTE on 09/08/2017.
//

import Foundation
import CodeWriter

public struct PropertyDescription: ModuleDependency {

    public struct Options {
        public let getVisibility: Visibility
        public let setVisibility: Visibility?
        public let isLazy: Bool
        public let isStatic: Bool
        public let isOverride: Bool
        public let isConstant: Bool
        public let isWeak: Bool

        public init(getVisibility: Visibility = .default, setVisibility: Visibility? = nil, isLazy: Bool = false, isStatic: Bool = false, isOverride: Bool = false, isConstant: Bool = false, isWeak: Bool = false) {
            self.getVisibility = getVisibility
            self.setVisibility = setVisibility
            self.isLazy = isLazy
            self.isStatic = isStatic
            self.isOverride = isOverride
            self.isConstant = isConstant
            self.isWeak = isWeak
        }
    }

    public struct ComputeDescription {
        public let get: CodeBuilder
        public let set: CodeBuilder?

        public init(get: CodeBuilder, set: CodeBuilder? = nil) {
            self.get = get
            self.set = set
        }
    }

    public let name: String
    public let type: String?
    public let options: Options
    public let modules: [String]
    public let value: CodeBuilder?
    public let attributes: [String]?
    public let compute: ComputeDescription?
    public let documentation: String?

    public init(name: String, options: Options = Options(), modules: [String] = [], type: String? = nil, value: CodeBuilder? = nil, attributes: [String]? = nil, compute: ComputeDescription? = nil, documentation: String? = nil) {
        self.name = name
        self.options = options
        self.type = type
        self.value = value
        self.attributes = attributes
        self.compute = compute
        self.documentation = documentation
        self.modules = modules
    }

    public func moduleDependencies() -> [String] {
        return self.modules
    }
}
