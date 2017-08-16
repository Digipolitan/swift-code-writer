//
//  MethodDescription.swift
//  SwiftCodeWriter
//
//  Created by Benoit BRIATTE on 09/08/2017.
//

import Foundation
import CodeWriter

public struct MethodDescription {

    public struct Options {
        public let visibility: Visibility
        public let isStatic: Bool
        public let isOverride: Bool
        public let isMutating: Bool

        public init(visibility: Visibility = .public, isStatic: Bool = false, isOverride: Bool = false, isMutating: Bool = false) {
            self.visibility = visibility
            self.isStatic = isStatic
            self.isOverride = isOverride
            self.isMutating = isMutating
        }
    }

    public let name: String
    public let code: CodeBuilder
    public let options: Options
    public let modules: [String]
    public let arguments: [String]?
    public let returnType: String?
    public let annotations: [String]?
    public let documentation: String?

    public init(name: String, code: CodeBuilder, options: Options = Options(), modules: [String] = [], arguments: [String]? = nil, returnType: String? = nil, annotations: [String]? = nil, documentation: String? = nil) {
        self.name = name
        self.code = code
        self.options = options
        self.modules = modules
        self.arguments = arguments
        self.returnType = returnType
        self.annotations = annotations
        self.documentation = documentation
    }
}
