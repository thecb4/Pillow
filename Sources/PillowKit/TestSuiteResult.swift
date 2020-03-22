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

  public init(classname: String, name: String, time: String, value: String) {
    self.classname = classname
    self.name = name
    self.time = time
    self.value = value
  }

  enum CodingKeys: String, CodingKey {
    case classname
    case name
    case time
    case value = ""
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
