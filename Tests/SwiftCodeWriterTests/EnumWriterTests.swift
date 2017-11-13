import XCTest
@testable import SwiftCodeWriter
import CodeWriter

class EnumWriterTests: XCTestCase {

    func testWriteEmptyEnumWithDocumentation() {
        let enumDescription = EnumDescription(name: "Direction", documentation: "MyDirectionEnum")
        XCTAssertEqual("/**\n * MyDirectionEnum\n */\nenum Direction {\n}", EnumWriter.default.write(description: enumDescription))
    }

    func testWriteEmptyPublicEnumWithRawType() {
        let enumDescription = EnumDescription(name: "Direction", options: .init(visibility: .public), rawType: "Int")
        XCTAssertEqual("public enum Direction: Int {\n}", EnumWriter.default.write(description: enumDescription))
    }

    func testWriteEmptyEnumWithExtendsAnd2Implements() {
        var enumDescription = EnumDescription(name: "Direction", rawType: "Int")
        enumDescription.implements.append("ITest")
        enumDescription.implements.append("ITest2")
        XCTAssertEqual("enum Direction: Int, ITest, ITest2 {\n}", EnumWriter.default.write(description: enumDescription))
    }

    func testWriteEmptyEnumWithImplementsOnly() {
        var enumDescription = EnumDescription(name: "Direction")
        enumDescription.implements.append("ITest")
        XCTAssertEqual("enum Direction: ITest {\n}", EnumWriter.default.write(description: enumDescription))
    }

    func testWriteEnumWith2Cases() {
        var enumDescription = EnumDescription(name: "Direction", rawType: "Int")
        enumDescription.cases.append(.init(name: "left", rawValue: "1"))
        enumDescription.cases.append(.init(name: "right", documentation: "Turn right"))
        XCTAssertEqual("enum Direction: Int {\n    case left = 1\n    // Turn right\n    case right\n}", EnumWriter.default.write(description: enumDescription))
    }

    static var allTests = [
        ("testWriteEmptyEnumWithDocumentation", testWriteEmptyEnumWithDocumentation),
        ("testWriteEmptyPublicEnumWithRawType", testWriteEmptyPublicEnumWithRawType),
        ("testWriteEmptyEnumWithExtendsAnd2Implements", testWriteEmptyEnumWithExtendsAnd2Implements),
        ("testWriteEmptyEnumWithImplementsOnly", testWriteEmptyEnumWithImplementsOnly),
        ("testWriteEnumWith2Cases", testWriteEnumWith2Cases)
    ]
}
