//
// Cavelle Benjamin
// 2020-Mar-21
//

import XMLCoder

public struct TestResults: Codable, DynamicNodeEncoding {
  public let results: [TestSuiteResult]

  public init(results: [TestSuiteResult]) {
    self.results = results
  }

  enum CodingKeys: String, CodingKey {
    case results = "testsuite"
  }

  public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
    switch key {
      default:
        return .element
    }
  }
}

public struct TestSuiteResult: Codable, DynamicNodeEncoding {
  public let name: String
  public let errors: String
  public let tests: String
  public let failures: String
  public let time: String

  public let testCaseResults: [TestCaseResult]

  public init(name: String, errors: String, tests: String, failures: String, time: String, testCaseResults: [TestCaseResult]) {
    self.name = name
    self.errors = errors
    self.tests = tests
    self.failures = failures
    self.time = time
    self.testCaseResults = testCaseResults
  }

  enum CodingKeys: String, CodingKey {
    case name
    case errors
    case tests
    case failures
    case time
    case testCaseResults = "testcase"
  }

  public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
    switch key {
      case CodingKeys.name, CodingKeys.errors, CodingKeys.tests, CodingKeys.failures, CodingKeys.time:
        return .attribute
      default:
        return .element
    }
  }
}

public struct TestCaseResult: Codable, DynamicNodeEncoding {
  public let classname: String
  public let name: String
  public let time: String
  public let value: String
  public let failure: FailureResult?

  public init(classname: String, name: String, time: String, value: String, failure: FailureResult?) {
    self.classname = classname
    self.name = name
    self.time = time
    self.value = value
    self.failure = failure
  }

  enum CodingKeys: String, CodingKey {
    case classname
    case name
    case time
    case value = ""
    case failure
  }

  public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
    switch key {
      case CodingKeys.classname, CodingKeys.name, CodingKeys.time:
        return .attribute
      default:
        return .element
    }
  }
}

public struct FailureResult: Codable, DynamicNodeEncoding {
  public let message: String
  public let value: String

  public init(message: String, value: String) {
    self.message = message
    self.value = value
  }

  enum CodingKeys: String, CodingKey {
    case message
    case value = ""
  }

  public static func nodeEncoding(for key: CodingKey) -> XMLEncoder.NodeEncoding {
    switch key {
      case CodingKeys.message:
        return .attribute
      default:
        return .element
    }
  }
}

extension TestResults {
  public static func parse(_ string: String) throws -> TestResults {
    guard let data = string.data(using: .utf8) else { throw CodableError.stringToDataError(string) }

    guard let results = try? XMLDecoder().decode(TestResults.self, from: data) else { throw CodableError.decodeError(string) }

    return results
  }
}

extension TestResults {
  public var table: String {
    let transformer = Transformer.textTable

    return transformer.fancyString(for: results[0].testCaseResults) ?? "no data"
  }
}
