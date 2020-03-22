import TextTable

public struct Transformer {}

extension Transformer {
  public static var textTable: TextTable<TestCaseResult> {
    TextTable<TestCaseResult> {
      [
        Column("Test Group" <- $0.classname),
        Column("Test" <- $0.name),
        Column("Status" <- $0.failure == nil ? "Passed" : "Failed", align: .right)
      ]
    }
  }
}

extension TextTable where T == TestCaseResult {
  public func fancyString<C: Collection>(for data: C) -> String? where C.Iterator.Element == T {
    string(for: data, style: Style.fancy)
  }
}
