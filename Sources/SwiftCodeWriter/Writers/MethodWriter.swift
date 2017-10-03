//
//  MethodWriter.swift
//  SwiftCodeWriter
//
//  Created by Benoit BRIATTE on 16/08/2017.
//

import Foundation
import CodeWriter

struct MethodWriter: CodeWriter {

    public typealias Description = MethodDescription

    public static let `default` = MethodWriter()

    private init() {}

    public func write(description: MethodDescription, depth: Int) -> String {
        let builder = CodeBuilder(depth: depth)
        if let documentation = description.documentation {
            if documentation.index(of: "\n") != nil {
                builder.add(string: DocumentationWriter.MultiLine.default.write(documentation: documentation, depth: depth), crlf: true)
            } else {
                builder.add(line: DocumentationWriter.SingleLine.default.write(documentation: documentation))
            }
        }
        description.attributes?.forEach { builder.add(line: $0) }

        var options: [String] = []
        if description.options.visibility != .default {
            options.append(description.options.visibility.rawValue)
        }

        if description.options.isOverride {
            options.append("override")
        }
        if description.options.isMutating {
            options.append("mutating")
        }
        if description.options.isStatic {
            options.append("static")
        }
        options.append("func")

        var method: String = "\(description.name)("
        if let arguments = description.arguments {
            method += arguments.joined(separator: ", ")
        }
        method += ")"

        options.append(method)

        if description.options.throwsException {
            options.append("throws")
        }

        if let returnType = description.returnType {
            options.append("-> \(returnType)")
        }

        if let impl = description.code {
            options.append("{")
            builder.add(line: options.joined(separator: " "))
            builder.rightTab().add(code: impl).leftTab()
            builder.add(string: "}", indent: true)
        } else {
            builder.add(string: options.joined(separator: " "), indent: true)
        }
        
        return builder.build()
    }
}
