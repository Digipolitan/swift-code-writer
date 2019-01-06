import XCTest

import CodeWriterTests

var tests = [XCTestCaseEntry]()
tests += ClassPropertyWriterTests.allTests()
tests += ClassWriterTests.allTests()
tests += EnumWriterTests.allTests()
tests += ExtensionWriterTests.allTests()
tests += FileWriterTests.allTests()
tests += InitializerWriterTests.allTests()
tests += MethodWriterTests.allTests()
tests += ProtocolPropertyWriterTests.allTests()
tests += ProtocolWriterTests.allTests()
XCTMain(tests)
