//
//  File.swift
//
//
//  Created by Cavelle Benjamin on 20-Mar-22 (12).
//

import Foundation
import Path

enum CLIError: Error {
  case invalidFile(Path)
  case parseError(String)
}

extension CLIError {
  var localizedDescription: String {
    switch self {
      case let CLIError.invalidFile(path):
        return "Check the path: \(path). Could not load data."
      case let CLIError.parseError(string):
        return "Check string: \(string)\n. Could not parse data."
    }
  }
}
