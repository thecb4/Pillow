//
// Cavelle Benjamin
// 2020-Mar-21

import XCTest
@testable import PillowCLI

final class CLITests: XCTestCase {
  func testCLIParse() throws {
    // given
    let arguments: [String] = []

    // when
    AssertParse(CLI.self, arguments) { _ in
      // then
    }
  }
}
