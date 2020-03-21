import XCTest

import PillowCLITests
import PillowTests

var tests = [XCTestCaseEntry]()
tests += PillowCLITests.__allTests()
tests += PillowTests.__allTests()

XCTMain(tests)
