//
//  FileWriter.swift
//  SwiftCodeWriter
//
//  Created by Benoit BRIATTE on 10/08/2017.
//

import Foundation
import CodeWriter

public struct FileWriter: CodeWriter {

    public typealias Description = FileDescription

    public static let `default` = FileWriter()

    private init() {}

    public func write(description: FileDescription, depth: Int) -> String {

        var body: [String] = []
        if let documentation = description.documentation {
            body.append(DocumentationWriter.MultiLine.default.write(documentation: documentation, mode: .slashes))
        }
        let modules = description.moduleDependencies()
        if modules.count > 0 {
            body.append(description.moduleDependencies().map { "import \($0)" }.joined(separator: "\n"))
        }
        if description.properties.count > 0 {
            body.append(description.properties.map { ClassPropertyWriter.default.write(description: $0, depth: depth) }.joined(separator: "\n"))
        }
        if description.protocols.count > 0 {
            body.append(description.protocols.map { ProtocolWriter.default.write(description: $0, depth: depth) }.joined(separator: "\n\n"))
        }
        if description.classes.count > 0 {
            body.append(description.classes.map { ClassWriter.default.write(description: $0, depth: depth) }.joined(separator: "\n\n"))
        }
        if description.enums.count > 0 {
            body.append(description.enums.map { EnumWriter.default.write(description: $0, depth: depth) }.joined(separator: "\n\n"))
        }
        if description.extensions.count > 0 {
            body.append(description.extensions.map { ExtensionWriter.default.write(description: $0, depth: depth) }.joined(separator: "\n\n"))
        }
        if description.methods.count > 0 {
            body.append(description.methods.map { MethodWriter.default.write(description: $0, depth: depth) }.joined(separator: "\n\n"))
        }
        return body.joined(separator: "\n\n") + "\n"
    }
}
