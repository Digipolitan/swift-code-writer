import XCTest
@testable import SwiftCodeWriter
import CodeWriter

enum Test: Int {
    enum Z {

    }
    struct W {

    }
    class K {

    }

    case a
    case b

    init?(text: String) {
        self.init(rawValue: 2)
    }

    private static let c = ""

    func test() {

    }

}

class ExtensionWriterTests: XCTestCase {

    func testWriteEmptyExtension() {
        Test.a.test()
        let extensionDescription = ExtensionDescription(target: "String")
        XCTAssertEqual("extension String {\n}", ExtensionWriter.default.write(description: extensionDescription))
    }

    func testWriteEmptyPublicExtensionWithImplements() {
        var extensionDescription = ExtensionDescription(target: "String", options: .init(visibility: .public))
        extensionDescription.implements.append("Compatable")
        XCTAssertEqual("public extension String: Compatable {\n}", ExtensionWriter.default.write(description: extensionDescription))
    }

    func testWriteExtensionWithProperty() {
        var extensionDescription = ExtensionDescription(target: "String")
        let getBuilder = CodeBuilder.from(code: "return \"hello\"")
        extensionDescription.properties.append(PropertyDescription(name: "hello", type: "String", compute: .init(get: getBuilder)))
        XCTAssertEqual("extension String {\n\tvar hello: String {\n\t\treturn \"hello\"\n\t}\n}", ExtensionWriter.default.write(description: extensionDescription))
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
        XCTAssertEqual("extension String {\n\tvar hello: String {\n\t\treturn \"hello\"\n\t}\n\n\tfunc test() {\n\t}\n\n\tfunc test2() {\n\t}\n}", ExtensionWriter.default.write(description: extensionDescription))
    }

    static var allTests = [
        ("testWriteEmptyExtension", testWriteEmptyExtension),
        ("testWriteEmptyPublicExtensionWithImplements", testWriteEmptyPublicExtensionWithImplements),
        ("testWriteExtensionWithProperty", testWriteExtensionWithProperty),
        ("testWriteExtensionWithAttributes", testWriteExtensionWithAttributes),
        ("testWriteClassWithPropertyAndMethods", testWriteClassWithPropertyAndMethods)
    ]
}

