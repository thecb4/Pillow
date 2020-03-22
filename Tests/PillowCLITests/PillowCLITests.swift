//
// Cavelle Benjamin
// 2020-Mar-21

import XCTest
import TestHelpers
import Path
@testable import PillowCLI

extension CLITests: Testable {}

final class CLITests: XCTestCase {
  func testCLIParse() throws {
    // given
    let arguments: [String] = []
    let expectedPath = packageDirectory / "Tests/Results.xml"

    // when
    AssertParse(CLI.self, arguments) { cli in

      // then
      XCTAssertEqual(cli.testResults, expectedPath)
    }
  }
}
