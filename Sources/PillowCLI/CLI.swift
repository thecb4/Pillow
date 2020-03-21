//
// Cavelle Benjamin
// 2020-Mar-21

import ArgumentParser

public struct CLI: ParsableCommand {
  public static var configuration = CommandConfiguration(
    abstract: "A utility for reformatting swift test output"
  )

  public init() {}

  public func run() throws {
    print("Hello, world!")
  }
}
