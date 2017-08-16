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
        public let throwsException: Bool

        public init(visibility: Visibility = .default, isStatic: Bool = false, isOverride: Bool = false, isMutating: Bool = false, throwsException: Bool = false) {
            self.visibility = visibility
            self.isStatic = isStatic
            self.isOverride = isOverride
            self.isMutating = isMutating
            self.throwsException = throwsException
        }
    }

    public let name: String
    public let code: CodeBuilder?
    public let options: Options
    public let modules: [String]
    public let arguments: [String]?
    public let returnType: String?
    public let attributes: [String]?
    public let documentation: String?

    public init(name: String, code: CodeBuilder? = nil, options: Options = Options(), modules: [String] = [], arguments: [String]? = nil, returnType: String? = nil, attributes: [String]? = nil, documentation: String? = nil) {
        self.name = name
        self.code = code
        self.options = options
        self.modules = modules
        self.arguments = arguments
        self.returnType = returnType
        self.attributes = attributes
        self.documentation = documentation
    }
}
