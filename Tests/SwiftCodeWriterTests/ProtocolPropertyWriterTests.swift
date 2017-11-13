import XCTest
@testable import SwiftCodeWriter
import CodeWriter

class ProtocolPropertyWriterTests: XCTestCase {

    func testStaticProperty() {
        let propertyDescription = PropertyDescription(name: "sample", options: .init(isStatic: true))
        XCTAssertEqual("static var sample: Any { get set }", ProtocolPropertyWriter.default.write(description: propertyDescription))
    }

    func testGetOnlyStringProperty() {
        let propertyDescription = PropertyDescription(name: "sample", options: .init(setVisibility: .private), type: "String")
        XCTAssertEqual("var sample: String { get }", ProtocolPropertyWriter.default.write(description: propertyDescription))
    }

    func testGetSetWeakProperty() {
        let propertyDescription = PropertyDescription(name: "sample", options: .init(isWeak: true), type: "AnyObject?")
        XCTAssertEqual("weak var sample: AnyObject? { get set }", ProtocolPropertyWriter.default.write(description: propertyDescription))
    }

    func testPropertyWithSingleLineDocumentation() {
        let propertyDescription = PropertyDescription(name: "sample", type: "Int?", documentation: "MyDoc")
        XCTAssertEqual("// MyDoc\nvar sample: Int? { get set }", ProtocolPropertyWriter.default.write(description: propertyDescription))
    }

    static var allTests = [
        ("testStaticProperty", testStaticProperty),
        ("testGetOnlyStringProperty", testGetOnlyStringProperty),
        ("testGetSetWeakProperty", testGetSetWeakProperty),
        ("testPropertyWithSingleLineDocumentation", testPropertyWithSingleLineDocumentation)
    ]
}
