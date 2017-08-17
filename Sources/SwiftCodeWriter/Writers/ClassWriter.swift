//
//  ClassWriter.swift
//  SwiftCodeWriter
//
//  Created by Benoit BRIATTE on 10/08/2017.
//

import Foundation
import CodeWriter

struct ClassWriter: CodeWriter {

    public typealias Description = ClassDescription

    public static let `default` = ClassWriter()

    private init() {}

    public func write(description: ClassDescription, depth: Int) -> String {
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
        if description.options.isReferenceType {
            line.append("class")
        } else {
            line.append("struct")
        }

        var classTitle = description.name
        var commaImplementsSeparator = false
        if let parent = description.parent {
            classTitle += ": \(parent)"
            commaImplementsSeparator = true
        }
        description.implements.forEach {
            if commaImplementsSeparator {
                classTitle += ","
            } else {
                classTitle += ":"
                commaImplementsSeparator = true
            }
            classTitle += " \($0)"
        }

        line.append(classTitle)
        line.append("{")

        builder.add(string: line.joined(separator: " "), indent: true)
        parts.append(builder.build())

        var body: [String] = []
        if description.nestedClasses.count > 0 {
            body.append(description.nestedClasses.map { self.write(description: $0, depth: depth + 1) }.joined(separator: "\n\n"))
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

