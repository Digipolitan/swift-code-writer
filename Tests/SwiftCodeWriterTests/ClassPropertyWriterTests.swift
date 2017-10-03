import XCTest
@testable import SwiftCodeWriter
import CodeWriter

class ClassPropertyWriterTests: XCTestCase {

    func testPublicStaticConstProperty() {
        let propertyDescription = PropertyDescription(name: "sample", options: .init(getVisibility: .public, isStatic: true, isConstant: true), value: CodeBuilder.from(code: "\"hello\""))
        XCTAssertEqual("public static let sample = \"hello\"", ClassPropertyWriter.default.write(description: propertyDescription))
    }

    func testLazyProperty() {
        let lazyValue = CodeBuilder()
        lazyValue.add(line: "{").rightTab().add(line: "return \"hello\"").leftTab().add(string: "}()", indent: true)
        let propertyDescription = PropertyDescription(name: "sample", options: .init(isLazy: true), type: "String", value: lazyValue)
        XCTAssertEqual("lazy var sample: String = {\n    return \"hello\"\n}()", ClassPropertyWriter.default.write(description: propertyDescription))
    }

    func testGetOnlyPrivateProperty() {
        let getBuilder = CodeBuilder.from(code: "return [\"hello\"]", crlf: true)
        let propertyDescription = PropertyDescription(name: "sample", options: .init(setVisibility: .private), type: "[String]", compute: .init(get: getBuilder))
        XCTAssertEqual("private(set) var sample: [String] {\n    return [\"hello\"]\n}", ClassPropertyWriter.default.write(description: propertyDescription))
    }

    func testGetSetOpenWeakProperty() {
        let getBuilder = CodeBuilder.from(code: "return self._sample", crlf: true)
        let setBuilder = CodeBuilder.from(code: "self._sample = newValue", crlf: true)
        let propertyDescription = PropertyDescription(name: "sample", options: .init(getVisibility: .open, isWeak: true), type: "Int", compute: .init(get: getBuilder, set: setBuilder))
        XCTAssertEqual("open weak var sample: Int {\n    get {\n        return self._sample\n    }\n    set {\n        self._sample = newValue\n    }\n}", ClassPropertyWriter.default.write(description: propertyDescription))
    }

    func testPropertyWithSingleLineDocumentationWith1Depth() {
        let propertyDescription = PropertyDescription(name: "sample", type: "Int?", documentation: "MyDoc")
        XCTAssertEqual("    // MyDoc\n    var sample: Int?", ClassPropertyWriter.default.write(description: propertyDescription, depth: 1))
    }

    func testPropertyWithMultiLineDocumentationWith1Depth() {
        let propertyDescription = PropertyDescription(name: "sample", options: .init(getVisibility: .public), type: "Int?", documentation: "MyDoc\nMultiLine")
        XCTAssertEqual("    /**\n     * MyDoc\n     * MultiLine\n     */\n    public var sample: Int?", ClassPropertyWriter.default.write(description: propertyDescription, depth: 1))
    }

    func testPropertyWithAttributes() {
        let propertyDescription = PropertyDescription(name: "sample", type: "String!", attributes: ["@IBOutlet"])
        XCTAssertEqual("@IBOutlet\nvar sample: String!", ClassPropertyWriter.default.write(description: propertyDescription))
    }

    static var allTests = [
        ("testPublicStaticConstProperty", testPublicStaticConstProperty),
        ("testLazyProperty", testLazyProperty),
        ("testGetOnlyPrivateProperty", testGetOnlyPrivateProperty),
        ("testGetSetOpenWeakProperty", testGetSetOpenWeakProperty),
        ("testPropertyWithSingleLineDocumentationWith1Depth", testPropertyWithSingleLineDocumentationWith1Depth),
        ("testPropertyWithMultiLineDocumentationWith1Depth", testPropertyWithMultiLineDocumentationWith1Depth),
        ("testPropertyWithAttributes", testPropertyWithAttributes)
    ]
}
