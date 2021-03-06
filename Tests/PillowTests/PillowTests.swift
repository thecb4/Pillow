import XCTest
import class Foundation.Bundle
import TestHelpers

@available(macOS 10.13, *)
class PillowTests: XCTestCase, TestableExecutable {
  static var queue: DispatchQueue = DispatchQueue(label: "\(PillowTests.self)")
  static var executableName: String = "pillow"

  var process: Process?
  var launched: Bool = false

  func testNoArguments() throws {
    // given
    try configureProcess(arguments: [], environment: ["CWD": testFixturesDirectory.string], cwd: testFixturesDirectory.url)
    let expected =
      """
      ╒═════════════════════════╤═════════════════╤════════╕
      │ Test Group              │ Test            │ Status │
      ╞═════════════════════════╪═════════════════╪════════╡
      │ PillowCLITests.CLITests │ testCLIParse    │ Passed │
      ├─────────────────────────┼─────────────────┼────────┤
      │ PillowTests.PillowTests │ testNoArguments │ Passed │
      ╘═════════════════════════╧═════════════════╧════════╛
      """ + .executableEnding

    // when
    let data = try execute()
    guard let outString = String(data: data.0, encoding: .utf8) else { XCTFail(); return }
    guard let errString = String(data: data.1, encoding: .utf8) else { XCTFail(); return }

    // then
    XCTAssertEqual(outString, expected)
    XCTAssertEqual(errString, "")
  }
}
