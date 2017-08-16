import XCTest
@testable import SwiftCodeWriter

class SwiftFileWriterTests: XCTestCase {

    func testWriteEmptyFile() {
        let fileDescription = FileDescription()
        XCTAssertEqual("", FileWriter.default.write(description: fileDescription))
    }

    func testWriteOnlyDocumentationFile() {
        let fileDescription = FileDescription(documentation: "SwiftCodeWriter.swift\nSwiftCodeWriter\n\nCreated by Benoit BRIATTE on XX/XX/XXXX.")
        XCTAssertEqual("//\n//  SwiftCodeWriter.swift\n//  SwiftCodeWriter\n//\n//  Created by Benoit BRIATTE on XX/XX/XXXX.\n//\n", FileWriter.default.write(description: fileDescription))
    }

    static var allTests = [
        ("testWriteEmptyFile", testWriteEmptyFile),
        ("testWriteOnlyDocumentationFile", testWriteOnlyDocumentationFile)
    ]
}
