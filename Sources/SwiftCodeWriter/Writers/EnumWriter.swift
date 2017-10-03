//
//  EnumWriter.swift
//  SwiftCodeWriter
//
//  Created by Benoit BRIATTE on 10/08/2017.
//

import Foundation
import CodeWriter

struct EnumWriter: CodeWriter {

    public typealias Description = EnumDescription

    public static let `default` = EnumWriter()

    private init() {}

    public func write(description: EnumDescription, depth: Int) -> String {
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
        if description.options.isIndirect {
            line.append("indirect")
        }
        line.append("enum")

        var enumTitle = description.name
        var commaImplementsSeparator = false
        if let rawType = description.rawType {
            enumTitle += ": \(rawType)"
            commaImplementsSeparator = true
        }
        description.implements.forEach {
            if commaImplementsSeparator {
                enumTitle += ","
            } else {
                enumTitle += ":"
                commaImplementsSeparator = true
            }
            enumTitle += " \($0)"
        }

        line.append(enumTitle)
        line.append("{")

        builder.add(string: line.joined(separator: " "), indent: true)
        parts.append(builder.build())

        var body: [String] = []
        if description.cases.count > 0 {
            body.append(description.cases.map { self.write(enumCase: $0, depth: depth + 1) }.joined(separator: "\n"))
        }
        if description.nestedClasses.count > 0 {
            body.append(description.nestedClasses.map { ClassWriter.default.write(description: $0, depth: depth + 1) }.joined(separator: "\n\n"))
        }
        if description.nestedEnums.count > 0 {
            body.append(description.nestedEnums.map { self.write(description: $0, depth: depth + 1) }.joined(separator: "\n\n"))
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

    private func write(enumCase: EnumDescription.Case, depth: Int) -> String {
        let builder = CodeBuilder(depth: depth)

        if let documentation = enumCase.documentation {
            if documentation.index(of: "\n") != nil {
                builder.add(string: DocumentationWriter.MultiLine.default.write(documentation: documentation, depth: depth), crlf: true)
            } else {
                builder.add(line: DocumentationWriter.SingleLine.default.write(documentation: documentation))
            }
        }
        var line: [String] = []
        if enumCase.isIndirect {
            line.append("indirect")
        }
        line.append("case")
        var caseTitle = enumCase.name
        if let associatedValues = enumCase.associatedValues {
            caseTitle += "(\(associatedValues.joined(separator: ", ")))"
        }
        line.append(caseTitle)
        if let rawValue = enumCase.rawValue {
            line.append("=")
            line.append(rawValue)
        }
        builder.add(string: line.joined(separator: " "), indent: true)
        return builder.build()
    }
}
