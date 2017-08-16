//
//  DocumentationWriter.swift
//  SwiftCodeWriter
//
//  Created by Benoit BRIATTE on 10/08/2017.
//

import Foundation
import CodeWriter

public enum DocumentationWriter {

    public enum Mode {
        case stars
        case slashes
    }

    public struct SingleLine {

        public static let `default` = SingleLine()

        private init() { }

        public func write(documentation: String, depth: Int = 0, mode: Mode = .slashes) -> String {
            let builder = CodeBuilder(depth: depth)
            if mode == .stars {
                builder.add(line: "/** \(documentation) */")
            } else {
                builder.add(line: "// \(documentation)")
            }
            return builder.build()
        }
    }

    public struct MultiLine {

        public static let `default` = MultiLine()

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

        private func writeSlashes(documentation: String, to builder: CodeBuilder) {
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

        private func writeStars(documentation: String, to builder: CodeBuilder) {
            builder.add(line: "/**")
            documentation.components(separatedBy: "\n").forEach {
                if $0.count > 0 {
                    builder.add(line: " * \($0)")
                } else {
                    builder.add(line: " *")
                }
            }
            builder.add(line: " */")
        }
    }
}
