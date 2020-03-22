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
  }
}
