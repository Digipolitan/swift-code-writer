//
//  ProtocolPropertyWriter.swift
//  SwiftCodeWriter
//
//  Created by Benoit BRIATTE on 16/08/2017.
//

import Foundation
import CodeWriter

public struct ProtocolPropertyWriter: CodeWriter {

    public typealias Description = PropertyDescription

    public static let `default` = ProtocolPropertyWriter()

    private static let readOnlyProperty = [Visibility.filePrivate, Visibility.private, Visibility.internal]

    private init() {}

    public func write(description: PropertyDescription, depth: Int) -> String {
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

        if description.options.isStatic {
            options.append("static")
        }
        if description.options.isWeak {
            options.append("weak")
        }
        options.append("var \(description.name):")

        if let type = description.type {
            options.append(type)
        } else {
            options.append("Any")
        }

        if let setVisibility = description.options.setVisibility, ProtocolPropertyWriter.readOnlyProperty.contains(setVisibility) {
            options.append("{ get }")
        } else {
            options.append("{ get set }")
        }

        builder.add(string: options.joined(separator: " "), indent: true)

        return builder.build()
    }
}
