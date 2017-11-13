import XCTest
@testable import SwiftCodeWriter
import CodeWriter

class InitializerWriterTests: XCTestCase {

    func testWriteEmptyInit() {
        let initializerDescription = InitializerDescription()
        XCTAssertEqual("init()", InitializerWriter.default.write(description: initializerDescription))
    }

    func testWriteEmptyPublicInitWithEmptyImpl() {
        let initializerDescription = InitializerDescription(code: CodeBuilder(), options: .init(visibility: .public))
        XCTAssertEqual("public init() {\n}", InitializerWriter.default.write(description: initializerDescription))
    }

    func testWriteConvenienceOverrideMethodWithParametersNoImpl() {
        let initializerDescription = InitializerDescription(options: .init(isOverride: true, isConvenience: true), arguments: ["p1: Int", "p2: Float"])
        XCTAssertEqual("override convenience init(p1: Int, p2: Float)", InitializerWriter.default.write(description: initializerDescription))
    }

    func testWriteRequiredAttributesDocumentationAndReturnWithImpl() {
        let initializerDescription = InitializerDescription(code: CodeBuilder.from(code: "// TODO"),
                                                            options: .init(isRequired: true),
                                                            attributes: ["@available(iOS 10.0, macOS 10.12, *)"],
                                                            documentation: "multi\nline")
        XCTAssertEqual("/**\n * multi\n * line\n */\n@available(iOS 10.0, macOS 10.12, *)\nrequired init() {\n    // TODO\n}", InitializerWriter.default.write(description: initializerDescription))
    }

    func testMultiLineImpl() {
        let builder = CodeBuilder()
        builder.add(line: "first")
        builder.add(line: "second")
        let initializerDescription = InitializerDescription(code: builder)
        XCTAssertEqual("init() {\n    first\n    second\n}", InitializerWriter.default.write(description: initializerDescription))
    }

    static var allTests = [
        ("testWriteEmptyInit", testWriteEmptyInit),
        ("testWriteEmptyPublicInitWithEmptyImpl", testWriteEmptyPublicInitWithEmptyImpl),
        ("testWriteConvenienceOverrideMethodWithParametersNoImpl", testWriteConvenienceOverrideMethodWithParametersNoImpl),
        ("testWriteRequiredAttributesDocumentationAndReturnWithImpl", testWriteRequiredAttributesDocumentationAndReturnWithImpl),
        ("testMultiLineImpl", testMultiLineImpl)
    ]
}
