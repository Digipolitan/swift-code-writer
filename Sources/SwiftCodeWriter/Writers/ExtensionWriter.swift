//
//  ExtensionWriter.swift
//  SwiftCodeWriter
//
//  Created by Benoit BRIATTE on 10/08/2017.
//

import Foundation
import CodeWriter

public struct ExtensionWriter: CodeWriter {

    public typealias Description = ExtensionDescription

    public static let `default` = ExtensionWriter()

    private init() {}

    public func write(description: ExtensionDescription, depth: Int) -> String {
        var parts: [String] = []

        if let documentation = description.documentation {
            parts.append(DocumentationWriter.MultiLine.default.write(documentation: documentation, depth: depth))
        }

        let builder = CodeBuilder(depth: depth)

        description.attributes.forEach { builder.add(line: $0) }

        var line: [String] = []
        if description.options.visibility != .default {
            line.append(description.options.visibility.rawValue)
        }
        line.append("extension")

        var targetTitle = description.target
        var commaImplementsSeparator = false
        description.implements.forEach {
            if commaImplementsSeparator {
                targetTitle += ","
            } else {
                targetTitle += ":"
                commaImplementsSeparator = true
            }
            targetTitle += " \($0)"
        }

        line.append(targetTitle)
        line.append("{")

        builder.add(string: line.joined(separator: " "), indent: true)
        parts.append(builder.build())

        var body: [String] = []

        if description.nestedClasses.count > 0 {
            body.append(description.nestedClasses.map { ClassWriter.default.write(description: $0, depth: depth + 1) }.joined(separator: "\n\n"))
        }
        if description.nestedEnums.count > 0 {
            body.append(description.nestedEnums.map { EnumWriter.default.write(description: $0, depth: depth + 1) }.joined(separator: "\n\n"))
        }
        if description.properties.count > 0 {
            body.append(description.properties.map { ClassPropertyWriter.default.write(description: $0, depth: depth + 1) }.joined(separator: "\n"))
        }
        if description.initializers.count > 0 {
            body.append(description.initializers.map { InitializerWriter.default.write(description: $0, depth: depth + 1) }.joined(separator: "\n\n"))
        }
        if description.methods.count > 0 {
            body.append(description.methods.map { MethodWriter.default.write(description: $0, depth: depth + 1) }.joined(separator: "\n\n"))
        }
        if body.count > 0 {
            parts.append(body.joined(separator: "\n\n"))
        }

        let closeBuilder = CodeBuilder(depth: depth)
        closeBuilder.add(string: "}", indent: true, crlf: false)
        parts.append(closeBuilder.build())

        return parts.joined(separator: "\n")
    }
}
