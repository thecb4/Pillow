//
//  File.swift
//
//
//  Created by Cavelle Benjamin on 20-Mar-22 (12).
//

import Foundation

enum CodableError: Error {
  case stringToDataError(String)
  case decodeError(String)
}

extension CodableError {
  var localizedDescription: String {
    switch self {
      case let CodableError.stringToDataError(string):
        return "Check string: \(string)\n. Could not parse data."
      case let CodableError.decodeError(string):
        return "Check string: \(string)\n. Could not decode data."
    }
  }
}
