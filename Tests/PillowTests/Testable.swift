//
//  File.swift
//
//
//  Created by Cavelle Benjamin on 2020-Mar-21.
//

import Foundation

protocol Testable {
  var productsDirectory: URL { get }
  var fixturesDirectory: URL { get }
  var projectDirectory: URL { get }
}

extension Testable {
  /// Returns path to the built products directory.
  var productsDirectory: URL {
    #if os(macOS)
      for bundle in Bundle.allBundles where bundle.bundlePath.hasSuffix(".xctest") {
        return bundle.bundleURL.deletingLastPathComponent()
      }
      fatalError("couldn't find the products directory")
    #else
      return Bundle.main.bundleURL
    #endif
  }

  var fixturesDirectory: URL {
    URL(fileURLWithPath: #file)
      .deletingLastPathComponent()
      .deletingLastPathComponent()
      .appendingPathComponent("fixtures")
  }

  var projectDirectory: URL {
    URL(fileURLWithPath: #file)
      .deletingLastPathComponent()
      .deletingLastPathComponent()
      .deletingLastPathComponent()
  }
}
