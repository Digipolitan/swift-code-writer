//
//  ProtocolWriter.swift
//  SwiftCodeWriter
//
//  Created by Benoit BRIATTE on 16/08/2017.
//

import Foundation
import CodeWriter

public struct ProtocolWriter: CodeWriter {

    public typealias Description = ProtocolDescription

    public static let `default` = ProtocolWriter()

    private init() {}

    public func write(description: ProtocolDescription, depth: Int) -> String {
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
        line.append("protocol")

        var protocolTitle = description.name
        var commaImplementsSeparator = false
        description.implements.forEach {
            if commaImplementsSeparator {
                protocolTitle += ","
            } else {
                protocolTitle += ":"
                commaImplementsSeparator = true
            }
            protocolTitle += " \($0)"
        }
        line.append(protocolTitle)
        line.append("{")

        builder.add(string: line.joined(separator: " "), indent: true)

        parts.append(builder.build())

        var body: [String] = []
        if description.properties.count > 0 {
            body.append(description.properties.map { ProtocolPropertyWriter.default.write(description: $0, depth: depth + 1) }.joined(separator: "\n"))
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
