import XCTest
@testable import SwiftCodeWriter
import CodeWriter

class MethodWriterTests: XCTestCase {

    func testWriteEmptyMethod() {
        let methodDescription = MethodDescription(name: "sample")
        XCTAssertEqual("func sample()", MethodWriter.default.write(description: methodDescription))
    }

    func testWriteEmptyPublicMethodWithEmptyImpl() {
        let methodDescription = MethodDescription(name: "sample", code: CodeBuilder(), options: .init(visibility: .public))
        XCTAssertEqual("public func sample() {\n}", MethodWriter.default.write(description: methodDescription))
    }

    func testWriteStaticOverrideMethodWithParametersAndReturnNoImpl() {
        let methodDescription = MethodDescription(name: "sample", options: .init(isStatic: true, isOverride: true), arguments: ["p1: Int", "p2: Float"], returnType: "String?")
        XCTAssertEqual("override static func sample(p1: Int, p2: Float) -> String?", MethodWriter.default.write(description: methodDescription))
    }

    func testWriteMutatingAttributesDocumentationAndReturnWithImpl() {
        let methodDescription = MethodDescription(name: "sample", code: CodeBuilder.from(code: "return self"), options: .init(isMutating: true), returnType: "Self", attributes: ["@discardableResult"], documentation: "multi\nline")
        XCTAssertEqual("/**\n * multi\n * line\n */\n@discardableResult\nmutating func sample() -> Self {\n\treturn self\n}", MethodWriter.default.write(description: methodDescription))
    }

    func testMultiLineImpl() {
        let builder = CodeBuilder()
        builder.add(line: "first")
        builder.add(line: "second")
        let methodDescription = MethodDescription(name: "sample", code: builder)
        XCTAssertEqual("func sample() {\n\tfirst\n\tsecond\n}", MethodWriter.default.write(description: methodDescription))
    }

    static var allTests = [
        ("testWriteEmptyMethod", testWriteEmptyMethod),
        ("testWriteEmptyPublicMethodWithEmptyImpl", testWriteEmptyPublicMethodWithEmptyImpl),
        ("testWriteStaticOverrideMethodWithParametersAndReturnNoImpl", testWriteStaticOverrideMethodWithParametersAndReturnNoImpl),
        ("testWriteMutatingAttributesDocumentationAndReturnWithImpl", testWriteMutatingAttributesDocumentationAndReturnWithImpl),
        ("testMultiLineImpl", testMultiLineImpl)
    ]
}

