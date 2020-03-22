//
//  File.swift
//
//
//  Created by Cavelle Benjamin on 20-Mar-21 (12).
//

import Path
import ArgumentParser

extension Path: ExpressibleByArgument {
  public init?(argument: String) {
    self.init(argument)
  }
}
