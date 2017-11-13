import XCTest
@testable import SwiftCodeWriter

class FileWriterTests: XCTestCase {

    func testWriteEmptyFile() {
        let fileDescription = FileDescription()
        XCTAssertEqual("", FileWriter.default.write(description: fileDescription))
    }

    func testWriteOnlyDocumentationFile() {
        let fileDescription = FileDescription(documentation: "SwiftCodeWriter.swift\nSwiftCodeWriter\n\nCreated by Benoit BRIATTE on XX/XX/XXXX.")
        XCTAssertEqual("//\n//  SwiftCodeWriter.swift\n//  SwiftCodeWriter\n//\n//  Created by Benoit BRIATTE on XX/XX/XXXX.\n//", FileWriter.default.write(description: fileDescription))
    }

    func testWriteFileWithProtocolAndClass() {
        var fileDescription = FileDescription(documentation: "SwiftCodeWriter.swift\nSwiftCodeWriter\n\nCreated by Benoit BRIATTE on XX/XX/XXXX.")

        var protocolDescription = ProtocolDescription(name: "SampleDelegate", options: .init(visibility: .public))
        protocolDescription.implements.append("class")
        protocolDescription.methods.append(MethodDescription(name: "sample",
                                                             options: .init(throwsException: true),
                                                             modules: ["Foundation", "UIKit"],
                                                             arguments: ["str: NSString"],
                                                             returnType: "UIView"))
        fileDescription.protocols.append(protocolDescription)

        var classDescription = ClassDescription(name: "Sample", options: .init(visibility: .open))
        classDescription.properties.append(PropertyDescription(name: "delegate", options: .init(isWeak: true), type: "SampleDelegate?"))
        fileDescription.classes.append(classDescription)

        XCTAssertEqual("//\n//  SwiftCodeWriter.swift\n//  SwiftCodeWriter\n//\n//  Created by Benoit BRIATTE on XX/XX/XXXX.\n//\n\nimport Foundation\nimport UIKit\n\npublic protocol SampleDelegate: class {\n    func sample(str: NSString) throws -> UIView\n}\n\nopen class Sample {\n    weak var delegate: SampleDelegate?\n}",
                       FileWriter.default.write(description: fileDescription))
    }

    static var allTests = [
        ("testWriteEmptyFile", testWriteEmptyFile),
        ("testWriteOnlyDocumentationFile", testWriteOnlyDocumentationFile),
        ("testWriteFileWithProtocolAndClass", testWriteFileWithProtocolAndClass)
    ]
}
