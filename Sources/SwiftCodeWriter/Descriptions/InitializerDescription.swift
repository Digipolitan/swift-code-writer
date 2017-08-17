//
//  InitializerDescription.swift
//  SwiftCodeWriter
//
//  Created by Benoit BRIATTE on 09/08/2017.
//

import Foundation
import CodeWriter

public struct InitializerDescription: ModuleDependency {

    public struct Options {
        public let visibility: Visibility
        public let isOverride: Bool
        public let isConvenience: Bool
        public let isOptional: Bool
        public let isRequired: Bool
        public let throwsException: Bool

        public init(visibility: Visibility = .default, isOverride: Bool = false, isConvenience: Bool = false, isOptional: Bool = false, isRequired: Bool = false, throwsException: Bool = false) {
            self.visibility = visibility
            self.isOverride = isOverride
            self.isConvenience = isConvenience
            self.isOptional = isOptional
            self.isRequired = isRequired
            self.throwsException = throwsException
        }
    }

    public let code: CodeBuilder?
    public let options: Options
    public let modules: [String]
    public let arguments: [String]?
    public let attributes: [String]?
    public let documentation: String?

    public init(code: CodeBuilder? = nil, options: Options = Options(), modules: [String] = [], arguments: [String]? = nil, attributes: [String]? = nil, documentation: String? = nil) {
        self.code = code
        self.options = options
        self.modules = modules
        self.arguments = arguments
        self.attributes = attributes
        self.documentation = documentation
    }

    public func moduleDependencies() -> [String] {
        return self.modules
    }
}
