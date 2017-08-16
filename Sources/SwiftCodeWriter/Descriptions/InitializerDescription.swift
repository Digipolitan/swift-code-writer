//
//  InitializerDescription.swift
//  SwiftCodeWriter
//
//  Created by Benoit BRIATTE on 09/08/2017.
//

import Foundation
import CodeWriter

public struct InitializerDescription {

    public struct Options {
        public let visibility: Visibility
        public let isOverride: Bool
        public let isConvenience: Bool
        public let isOptional: Bool
        public let isRequired: Bool

        public init(visibility: Visibility = .public, isOverride: Bool = false, isConvenience: Bool = false, isOptional: Bool = false, isRequired: Bool = false) {
            self.visibility = visibility
            self.isOverride = isOverride
            self.isConvenience = isConvenience
            self.isOptional = isOptional
            self.isRequired = isRequired
        }
    }

    public let code: CodeBuilder
    public let options: Options
    public let modules: [String]
    public let arguments: [String]?
    public let annotations: [String]?
    public let documentation: String?

    public init(code: CodeBuilder, options: Options = Options(), modules: [String] = [], arguments: [String]? = nil, annotations: [String]? = nil, documentation: String? = nil) {
        self.code = code
        self.options = options
        self.modules = modules
        self.arguments = arguments
        self.annotations = annotations
        self.documentation = documentation
    }
}
