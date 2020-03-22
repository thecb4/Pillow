//
// Cavelle Benjamin
// 2020-Mar-21
//

import XCTest
import XMLCoder
import PillowKit

final class PillowKitTests: XCTestCase {
  func testCodableTestCaseResultNoFailuresDecode() {
    // given
    let xml =
      """
      <testcase classname="PillowKitTests.PillowKitTests" name="testCodableTestCaseResultNoFailures" time="0.0">
      </testcase>
      """

    // when
    guard let data = xml.data(using: .utf8) else { XCTFail(); return }

    let testCaseResult = try? XMLDecoder().decode(TestCaseResult.self, from: data)

    XCTAssertNotNil(testCaseResult)
    XCTAssertEqual(testCaseResult?.classname, "PillowKitTests.PillowKitTests")
    XCTAssertEqual(testCaseResult?.name, "testCodableTestCaseResultNoFailures")
    XCTAssertEqual(testCaseResult?.time, "0.0")
  }

  func testCodableTestCaseResultNoFailuresEncode() {
    // given
    let result = TestCaseResult(
      classname: "PillowKitTests.PillowKitTests",
      name: "testCodableTestCaseResultNoFailures",
      time: "0.0",
      value: "",
      failure: nil
    )

    let expectedXML =
      """
      <testcase classname="PillowKitTests.PillowKitTests" name="testCodableTestCaseResultNoFailures" time="0.0"></testcase>
      """

    // when
    guard let data = try? XMLEncoder().encode(result, withRootKey: "testcase") else { XCTFail(); return }
    guard let actualXML = String(data: data, encoding: .utf8) else { XCTFail(); return }

    XCTAssertEqual(actualXML, expectedXML)
  }

  func testCodableTestCaseResultFailuresDecode() {
    // given
    let xml =
      """
      <testcase classname="PillowKitTests.PillowKitTests" name="testCodableTestCaseResultFealuresDecode" time="0.0">
      <failure message="failed"></failure>
      </testcase>
      """

    // when
    guard let data = xml.data(using: .utf8) else { XCTFail(); return }

    let testCaseResult = try? XMLDecoder().decode(TestCaseResult.self, from: data)

    XCTAssertNotNil(testCaseResult)
    XCTAssertEqual(testCaseResult?.classname, "PillowKitTests.PillowKitTests")
    XCTAssertEqual(testCaseResult?.name, "testCodableTestCaseResultFealuresDecode")
    XCTAssertEqual(testCaseResult?.time, "0.0")
    XCTAssertNotNil(testCaseResult?.failure)
    XCTAssertEqual(testCaseResult?.failure?.message, "failed")
  }

  func testCodableTestCaseResultFailuresEncode() {
    // given
    let result = TestCaseResult(
      classname: "PillowKitTests.PillowKitTests",
      name: "testCodableTestCaseResultNoFailures",
      time: "0.0",
      value: "",
      failure: FailureResult(message: "failed", value: "")
    )

    let expectedXML =
      """
      <testcase classname="PillowKitTests.PillowKitTests" name="testCodableTestCaseResultNoFailures" time="0.0"><failure message="failed"></failure></testcase>
      """

    // when
    guard let data = try? XMLEncoder().encode(result, withRootKey: "testcase") else { XCTFail(); return }
    guard let actualXML = String(data: data, encoding: .utf8) else { XCTFail(); return }

    XCTAssertEqual(actualXML, expectedXML)
  }

  func testCodableTestSuiteResultNoFailuresDecode() {
    // given
    let xml =
      """
      <testsuite name="TestResults" errors="0" tests="2" failures="0" time="0.0">
      <testcase classname="PillowKitTests.PillowKitTests" name="testCodableTestCaseResultNoFailuresDecode" time="0.0">
      </testcase>
      <testcase classname="PillowKitTests.PillowKitTests" name="testCodableTestCaseResultNoFailuresEncode" time="0.0">
      </testcase>
      </testsuite>
      """

    // when
    guard let data = xml.data(using: .utf8) else { XCTFail(); return }

    let testSuiteResult = try? XMLDecoder().decode(TestSuiteResult.self, from: data)

    XCTAssertNotNil(testSuiteResult)
    XCTAssertEqual(testSuiteResult?.name, "TestResults")
    XCTAssertEqual(testSuiteResult?.errors, "0")
    XCTAssertEqual(testSuiteResult?.tests, "2")
    XCTAssertEqual(testSuiteResult?.failures, "0")
    XCTAssertEqual(testSuiteResult?.time, "0.0")
    XCTAssertEqual(testSuiteResult?.testCaseResults.count, 2)
  }
}
