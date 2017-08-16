//
//  InitializerWriter.swift
//  SwiftCodeWriter
//
//  Created by Benoit BRIATTE on 16/08/2017.
//

import Foundation
import CodeWriter

public struct InitializerWriter: CodeWriter {

    public typealias Description = InitializerDescription

    public static let `default` = InitializerWriter()

    private init() {}

    public func write(description: InitializerDescription, depth: Int) -> String {
        let builder = CodeBuilder(depth: depth)
        if let documentation = description.documentation {
            if documentation.index(of: "\n") != nil {
                builder.add(string: DocumentationWriter.MultiLine.default.write(documentation: documentation, depth: depth))
            } else {
                builder.add(string: DocumentationWriter.SingleLine.default.write(documentation: documentation, depth: depth))
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
        if description.options.isRequired {
            options.append("required")
        }
        if description.options.isConvenience {
            options.append("convenience")
        }

        var method: String = "init"
        if description.options.isOptional {
            method += "?"
        }
        method += "("
        if let arguments = description.arguments {
            method += arguments.joined(separator: ", ")
        }
        method += ")"

        options.append(method)

        if description.options.throwsException {
            options.append("throws")
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
