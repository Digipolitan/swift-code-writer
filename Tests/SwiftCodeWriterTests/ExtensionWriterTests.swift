import XCTest
@testable import SwiftCodeWriter
import CodeWriter

class ExtensionWriterTests: XCTestCase {

    func testWriteEmptyExtensionWithDocumentation() {
        let extensionDescription = ExtensionDescription(target: "String", documentation: "MyStringExtension")
        XCTAssertEqual("/**\n * MyStringExtension\n */\nextension String {\n}", ExtensionWriter.default.write(description: extensionDescription))
    }

    func testWriteEmptyPublicExtensionWithImplements() {
        var extensionDescription = ExtensionDescription(target: "String", options: .init(visibility: .public))
        extensionDescription.implements.append("Comparable")
        XCTAssertEqual("public extension String: Comparable {\n}", ExtensionWriter.default.write(description: extensionDescription))
    }

    func testWriteExtensionWithProperty() {
        var extensionDescription = ExtensionDescription(target: "String")
        let getBuilder = CodeBuilder.from(code: "return \"hello\"")
        extensionDescription.properties.append(PropertyDescription(name: "hello", type: "String", compute: .init(get: getBuilder)))
        XCTAssertEqual("extension String {\n    var hello: String {\n        return \"hello\"\n    }\n}", ExtensionWriter.default.write(description: extensionDescription))
    }

    func testWriteExtensionWithAttributes() {
        var extensionDescription = ExtensionDescription(target: "String")
        extensionDescription.attributes.append("@available(iOS 10.0, macOS 10.12, *)")
        XCTAssertEqual("@available(iOS 10.0, macOS 10.12, *)\nextension String {\n}", ExtensionWriter.default.write(description: extensionDescription))
    }

    func testWriteClassWithPropertyAndMethods() {
        var extensionDescription = ExtensionDescription(target: "String")
        let getBuilder = CodeBuilder.from(code: "return \"hello\"")
        extensionDescription.properties.append(PropertyDescription(name: "hello", type: "String", compute: .init(get: getBuilder)))
        extensionDescription.methods.append(MethodDescription(name: "test", code: CodeBuilder()))
        extensionDescription.methods.append(MethodDescription(name: "test2", code: CodeBuilder()))
        XCTAssertEqual("extension String {\n    var hello: String {\n        return \"hello\"\n    }\n\n    func test() {\n    }\n\n    func test2() {\n    }\n}", ExtensionWriter.default.write(description: extensionDescription))
    }

    static var allTests = [
        ("testWriteEmptyExtensionWithDocumentation", testWriteEmptyExtensionWithDocumentation),
        ("testWriteEmptyPublicExtensionWithImplements", testWriteEmptyPublicExtensionWithImplements),
        ("testWriteExtensionWithProperty", testWriteExtensionWithProperty),
        ("testWriteExtensionWithAttributes", testWriteExtensionWithAttributes),
        ("testWriteClassWithPropertyAndMethods", testWriteClassWithPropertyAndMethods)
    ]
}

