import XCTest

#if !os(macOS)
public func allTests() -> [XCTestCaseEntry] {
    return [
        testCase(ClassPropertyWriterTests.allTests),
        testCase(ClassWriterTests.allTests),
        testCase(EnumWriterTests.allTests),
        testCase(ExtensionWriterTests.allTests),
        testCase(FileWriterTests.allTests),
        testCase(InitializerWriterTests.allTests),
        testCase(MethodWriterTests.allTests),
        testCase(ProtocolPropertyWriterTests.allTests),
        testCase(ProtocolWriterTests.allTests)
    ]
}
#endif
