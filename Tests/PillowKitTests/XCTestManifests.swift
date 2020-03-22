#if !canImport(ObjectiveC)
  import XCTest

  extension PillowKitTests {
    // DO NOT MODIFY: This is autogenerated, use:
    //   `swift test --generate-linuxmain`
    // to regenerate.
    static let __allTests__PillowKitTests = [
      ("testCodableTestCaseResultFailuresDecode", testCodableTestCaseResultFailuresDecode),
      ("testCodableTestCaseResultFailuresEncode", testCodableTestCaseResultFailuresEncode),
      ("testCodableTestCaseResultNoFailuresDecode", testCodableTestCaseResultNoFailuresDecode),
      ("testCodableTestCaseResultNoFailuresEncode", testCodableTestCaseResultNoFailuresEncode),
      ("testCodableTestResultsNoFailuresDecode", testCodableTestResultsNoFailuresDecode),
      ("testCodableTestResultsNoFailuresEncode", testCodableTestResultsNoFailuresEncode),
      ("testCodableTestSuiteResultNoFailuresDecode", testCodableTestSuiteResultNoFailuresDecode),
      ("testTransformer", testTransformer)
    ]
  }

  public func __allTests() -> [XCTestCaseEntry] {
    [
      testCase(PillowKitTests.__allTests__PillowKitTests)
    ]
  }
#endif
