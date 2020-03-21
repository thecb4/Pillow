//
// Cavelle Benjamin
// 2020-Mar-21
//

import XCTest
import ArgumentParser

public func AssertParse<A>(_ type: A.Type, _ arguments: [String], file: StaticString = #file, line: UInt = #line, closure: (A) throws -> Void) where A: ParsableArguments {
  do {
    let parsed = try type.parse(arguments)
    try closure(parsed)
  } catch {
    let message = type.message(for: error)
    XCTFail("\"\(message)\" — \(error)", file: file, line: line)
  }
}

public func AssertParseCommand<A: ParsableCommand>(_ rootCommand: ParsableCommand.Type, _ type: A.Type, _ arguments: [String], file: StaticString = #file, line: UInt = #line, closure: (A) throws -> Void) {
  do {
    let command = try rootCommand.parseAsRoot(arguments)
    guard let aCommand = command as? A else {
      XCTFail("Command is of unexpected type: \(command)", file: file, line: line)
      return
    }
    try closure(aCommand)
  } catch {
    let message = rootCommand.message(for: error)
    XCTFail("\"\(message)\" — \(error)", file: file, line: line)
  }
}
