//
//  ClassPropertyWriter.swift
//  SwiftCodeWriter
//
//  Created by Benoit BRIATTE on 16/08/2017.
//

import Foundation
import CodeWriter

public struct ClassPropertyWriter: CodeWriter {

    public typealias Description = PropertyDescription

    public static let `default` = ClassPropertyWriter()

    private init() {}

    public func write(description: PropertyDescription, depth: Int) -> String {
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
        if description.options.getVisibility != .default {
            options.append(description.options.getVisibility.rawValue)
        }
        if let setVisibility = description.options.setVisibility {
            options.append("\(setVisibility.rawValue)(set)")
        }
        if description.options.isLazy {
            options.append("lazy")
        }
        if description.options.isStatic {
            options.append("static")
        }
        if description.options.isWeak {
            options.append("weak")
        }
        if description.options.isConstant {
            options.append("let")
        } else {
            options.append("var")
        }

        if let type = description.type {
            options.append("\(description.name): \(type)")
        } else {
            options.append(description.name)
        }

        builder.add(string: options.joined(separator: " "), indent: true)
        if let value = description.value {
            builder.add(string: " = ")
            builder.add(code: value, indent: false, crlf: false)
        }

        if let compute = description.compute {
            builder.add(string: " {", crlf: true)
            builder.rightTab()
            if let set = compute.set {
                builder.add(line: "get {")
                builder.rightTab()
                builder.add(code: compute.get)
                builder.leftTab()
                builder.add(line: "}")
                builder.add(line: "set {")
                builder.rightTab()
                builder.add(code: set)
                builder.leftTab()
                builder.add(line: "}")
            } else {
                builder.add(code: compute.get)
            }
            builder.leftTab()
            builder.add(string: "}", indent: true)
        }
        
        return builder.build()
    }
}


