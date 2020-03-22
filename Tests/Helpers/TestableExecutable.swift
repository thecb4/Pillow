//
//  TestableCommand.swift
//
//
//  Created by Cavelle Benjamin on 2020-Mar-21å.
//

import Foundation

@available(macOS 10.13, *)
public protocol TestableExecutable: AnyObject, Testable {
  static var queue: DispatchQueue { get }
  static var executableName: String { get }
  var process: Process? { get set }
  var launched: Bool { get set }
  func configureProcess(arguments: [String], environment: [String: String], cwd: URL) throws
  func execute(capturingOutput: Bool) throws -> (Data, Data)
  func terminate()
}

@available(macOS 10.13, *)
extension TestableExecutable {
  public func configureProcess(arguments: [String], environment: [String: String] = [:], cwd: URL) throws {
    process = Process()
    let fooBinary = productsDirectory.url.appendingPathComponent(Self.executableName)
    process?.executableURL = fooBinary
    process?.currentDirectoryURL = cwd
    process?.arguments = arguments
    process?.environment = environment.merging(ProcessInfo.processInfo.environment) { current, _ in current }
  }

  public func execute(capturingOutput: Bool = true) throws -> (Data, Data) {
    let out = Pipe()
    var outData = Data()

    let err = Pipe()
    var errData = Data()

    if capturingOutput {
      process?.standardOutput = out
      process?.standardError = err
    }
    try Self.queue.sync {
      try process?.run()
      launched = true
    }
    if capturingOutput {
      outData = out.fileHandleForReading.readDataToEndOfFile()
      errData = err.fileHandleForReading.readDataToEndOfFile()
    }
    process?.waitUntilExit()

    return (outData, errData)
  }

  public func terminate() {
    Self.queue.sync {
      if launched {
        process?.terminate()
      }
    }
  }
}

extension UInt8 {
  public var character: Character {
    Character(UnicodeScalar(self))
  }
}

extension String {
  public static var executableEnding: String {
    let ending: [UInt8] = [10, 10]
    return String(ending.map { $0.character })
  }
}
