//
// Cavelle Benjamin
// 2020-Mar-21
//

import XMLCoder

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
