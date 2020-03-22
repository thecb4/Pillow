// swift-tools-version:5.1
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "Pillow",
  products: [
    // Products define the executables and libraries produced by a package, and make them visible to other packages.
    .library(name: "PillowKit", targets: ["PillowKit"]),
    .library(name: "PillowCLI", targets: ["PillowCLI"]),
    .executable(name: "pillow", targets: ["Pillow"])
  ],
  dependencies: [
    // Dependencies declare other packages that this package depends on.
    // .package(url: /* package url */, from: "1.0.0"),
    .package(url: "https://github.com/MaxDesiatov/XMLCoder.git", .branch("master")),
    // .package(url: "https://github.com/cfilipov/TextTable.git", .branch("master")),
    .package(url: "https://github.com/apple/swift-argument-parser.git", .branch("2d8a9bd")),
    .package(url: "https://github.com/mxcl/Path.swift.git", .exact("1.0.0"))
  ],
  targets: [
    // Targets are the basic building blocks of a package. A target can define a module or a test suite.
    // Targets can depend on other targets in this package, and on products in packages which this package depends on.
    .target(
      name: "Pillow",
      dependencies: ["PillowCLI"]
    ),
    .target(
      name: "PillowCLI",
      dependencies: ["ArgumentParser", "Path", "PillowKit"]
    ),
    .target(
      name: "PillowKit",
      dependencies: ["XMLCoder"]
    ),
    .target(
      name: "TestHelpers",
      dependencies: ["ArgumentParser", "Path"],
      path: "Tests/Helpers"
    ),
    .testTarget(
      name: "PillowTests",
      dependencies: ["Pillow", "TestHelpers"]
    ),
    .testTarget(
      name: "PillowCLITests",
      dependencies: ["PillowCLI", "ArgumentParser", "TestHelpers", "Path"]
    ),
    .testTarget(
      name: "PillowKitTests",
      dependencies: ["PillowKit", "XMLCoder"]
    )
  ]
)
