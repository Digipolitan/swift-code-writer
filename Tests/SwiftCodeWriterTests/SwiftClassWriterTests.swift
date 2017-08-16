import XCTest
@testable import SwiftCodeWriter

class ClassWriterTests: XCTestCase {

    func testWriteEmptyClass() {
        let classDescription = ClassDescription(name: "Sample")
        XCTAssertEqual("public class Sample {\n}", ClassWriter.default.write(description: classDescription))
    }

    func testWriteEmptyClassWithExtends() {
        let classDescription = ClassDescription(name: "Sample", parent: "MySuperClass")
        XCTAssertEqual("public class Sample: MySuperClass {\n}", ClassWriter.default.write(description: classDescription))
    }

    func testWriteEmptyClassWithExtendsAnd2Implements() {
        var classDescription = ClassDescription(name: "Sample", parent: "MySuperClass")
        classDescription.implements.append("ITest")
        classDescription.implements.append("ITest2")
        XCTAssertEqual("public class Sample: MySuperClass, ITest, ITest2 {\n}", ClassWriter.default.write(description: classDescription))
    }

    func testWriteEmptyClassWithImplementsOnly() {
        var classDescription = ClassDescription(name: "Sample")
        classDescription.implements.append("ITest")
        XCTAssertEqual("public class Sample: ITest {\n}", ClassWriter.default.write(description: classDescription))
    }

    static var allTests = [
        ("testWriteEmptyClass", testWriteEmptyClass),
        ("testWriteEmptyClassWithExtends", testWriteEmptyClassWithExtends),
        ("testWriteEmptyClassWithExtendsAnd2Implements", testWriteEmptyClassWithExtendsAnd2Implements),
        ("testWriteEmptyClassWithImplementsOnly", testWriteEmptyClassWithImplementsOnly)
    ]
}
