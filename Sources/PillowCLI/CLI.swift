//
// Cavelle Benjamin
// 2020-Mar-21

import Foundation
import Path
import ArgumentParser

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
    print("Hello, world!")
  }
}

extension CLI {
  static var xcode: Bool {
    ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] != nil
  }

  static var cwd: Path {
    if xcode {
      let path = Path(url: URL(fileURLWithPath: #file))!
      return path.parent.parent.parent
    }

    return Path(Path.cwd)
  }
}
