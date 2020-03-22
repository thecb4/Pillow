//
// Cavelle Benjamin
// 2020-Mar-21

import Foundation
import Path
import ArgumentParser
import PillowKit

public struct CLI: ParsableCommand {
  public static var configuration = CommandConfiguration(
    abstract: "A utility for reformatting swift test output"
  )

  @Option(
    default: CLI.cwd / "Tests/Results.xml",
    help: "Test results file for parsing"
  )
  var testResults: Path

  public init() {}

  public func run() throws {
    guard let string = try? String(contentsOf: testResults) else { throw CLIError.invalidFile(testResults) }

    let results = try TestResults.parse(string)

    print(results)
  }
}

extension CLI {
  static var xcode: Bool {
    ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
  }

  static var cwd: Path {
    if xcode {
      if let _cwd = ProcessInfo.processInfo.environment["CWD"], let path = Path(_cwd) {
        return path
      }
      let path = Path(url: URL(fileURLWithPath: #file))!
      return path.parent.parent.parent
    }

    return Path(Path.cwd)
  }
}
