//
//  File.swift
//
//
//  Created by Cavelle Benjamin on 2020-Mar-21.
//

import Foundation
import Path

public protocol Testable {
  var productsDirectory: Path { get }
  var testFixturesDirectory: Path { get }
  var packageDirectory: Path { get }
}

extension Testable {
  /// Returns path to the built products directory.
  public var productsDirectory: Path {
    #if os(macOS)
      for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
        return Path(url: bundle.bundleURL.deletingLastPathComponent())!
      }
      fatalError("couldn't find the products directory")
    #else
      return Path(url: Bundle.main.bundleURL)!
    #endif
  }

  public var testFixturesDirectory: Path {
    packageDirectory / "Tests/fixtures"
  }

  public var packageDirectory: Path {
    // necessary if you are using xcode
    if let _ = ProcessInfo.processInfo.environment["XCTestConfigurationFilePath"] {
      return productsDirectory
        .parent
        .parent
        .parent
        .parent
        .parent
    }

    return productsDirectory
      .parent
      .parent
      .parent
  }
}
