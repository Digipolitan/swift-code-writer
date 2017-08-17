//
//  FileWriter.swift
//  SwiftCodeWriter
//
//  Created by Benoit BRIATTE on 10/08/2017.
//

import Foundation
import CodeWriter

public struct FileWriter: CodeWriter {

    public typealias Description = FileDescription

    public static let `default` = FileWriter()

    private init() {}

    public func write(description: FileDescription, depth: Int) -> String {

        var parts: [String] = []

        if let documentation = description.documentation {
            parts.append(DocumentationWriter.MultiLine.default.write(documentation: documentation, mode: .slashes))
        }

        parts.append(contentsOf: description.moduleDependencies().map({ "import \($0)" }))

        /*

        ublic var classes: [ClassDescription]
        public var protocols: [ProtocolDescription]
        public var extensions: [ExtensionDescription]
        public var methods: [MethodDescription]
        public var properties: [PropertyDescription]
        public let documentation: String?
 */
        return parts.joined(separator: "\n")
    }
}
