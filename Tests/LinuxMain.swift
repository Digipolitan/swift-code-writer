import XCTest
@testable import SwiftCodeWriterTests

XCTMain([
  testCase(SwiftFileWriterTests.allTests),
  testCase(SwiftClassWriterTests.allTests)
])
