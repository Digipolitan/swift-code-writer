//
//  DocumentationSingleLineWriter.swift
//  SwiftCodeWriter
//
//  Created by Benoit BRIATTE on 10/08/2017.
//

import Foundation
import CodeWriter

class DocumentationSingleLineWriter {

    public enum Mode {
        case stars
        case slashes
    }

    public static let `default` = DocumentationSingleLineWriter()

    private init() { }

    public func write(documentation: String, depth: Int = 0, mode: Mode = .stars) -> String {

        let builder = CodeBuilder(depth: depth)
        if mode == .stars {
            self.writeStars(documentation: documentation, to: builder)
        } else {
            self.writeSlashes(documentation: documentation, to: builder)
        }
        return builder.build()
    }

    private func writeStars(documentation: String, to builder: CodeBuilder) {
        builder.add(line: "//")
        documentation.components(separatedBy: "\n").forEach {
            if $0.count > 0 {
                builder.add(line: "//  \($0)")
            } else {
                builder.add(line: "//")
            }
        }
        builder.add(line: "//")
    }

    private func writeSlashes(documentation: String, to builder: CodeBuilder) {
        builder.add(line: "/**")
        documentation.components(separatedBy: "\n").forEach {
            if $0.count > 0 {
                builder.add(line: " *  \($0)")
            } else {
                builder.add(line: " *")
            }
        }
        builder.add(line: " */")
    }
}
