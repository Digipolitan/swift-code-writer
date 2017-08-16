//
//  ClassWriter.swift
//  SwiftCodeWriter
//
//  Created by Benoit BRIATTE on 10/08/2017.
//

import Foundation
import CodeWriter

public class ClassWriter: CodeWriter {

    public typealias Description = ClassDescription

    public static let `default` = ClassWriter()

    private init() {}

    public func write(description: ClassDescription, depth: Int) -> String {
        var parts: [String] = []

        if let documentation = description.documentation {
            parts.append(DocumentationSingleLineWriter.default.write(documentation: documentation, depth: depth, mode: .stars))
        }

        let builder = CodeBuilder(depth: depth)
        builder.add(string: description.options.visibility.rawValue, indent: true)
        if description.options.isReferenceType {
            builder.add(string: " class")
        } else {
            builder.add(string: " struct")
        }
        builder.add(string: " \(description.name)")
        var commaImplementsSeparator = false
        if let parent = description.parent {
            builder.add(string: ": \(parent)")
            commaImplementsSeparator = true
        }
        description.implements.forEach {
            if commaImplementsSeparator {
                builder.add(string: ",")
            } else {
                builder.add(string: ":")
                commaImplementsSeparator = true
            }
            builder.add(string: " \($0)")
        }
        builder.add(string: " {")
        parts.append(builder.build())

        parts.append(contentsOf: description.nestedClasses.map { self.write(description: $0, depth: depth + 1) })

        let closeBuilder = CodeBuilder(depth: depth)
        closeBuilder.add(string: "}", indent: true, crlf: false)
        parts.append(closeBuilder.build())

        return parts.joined(separator: "\n")
    }
}

