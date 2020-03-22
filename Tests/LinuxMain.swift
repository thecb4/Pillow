import XCTest

import PillowCLITests
import PillowKitTests
import PillowTests

var tests = [XCTestCaseEntry]()
tests += PillowCLITests.__allTests()
tests += PillowKitTests.__allTests()
tests += PillowTests.__allTests()

XCTMain(tests)
