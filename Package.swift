// swift-tools-version: 5.10
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
  name: "ServiceLogosCLIForMacOS",
  platforms: [
    .macOS(.v14)
  ],
  products: [
    .executable(
      name: "service-logos",
      targets: [
        "ServiceLogosCLIForMacOS"
      ])
  ],
  dependencies: [
    .package(url: "https://github.com/apple/swift-argument-parser.git", from: "1.2.0"),
    .package(url: "https://github.com/swift-server/async-http-client.git", from: "1.9.0"),
    .package(url: "https://github.com/jpsim/Yams.git", from: "5.1.2"),
    .package(
      url: "https://github.com/apple/swift-testing.git",
      revision: "a2bf9a20321eeac8d1c7568c4a41eada88cee355"
    ),
  ],
  targets: [
    .executableTarget(
      name: "ServiceLogosCLIForMacOS",
      dependencies: [
        //        "ArgumentParser",
        //        "AsyncHTTPClient",
        //        "Yams",
        .product(name: "ArgumentParser", package: "swift-argument-parser"),
        .product(name: "AsyncHTTPClient", package: "async-http-client"),
        .product(name: "Yams", package: "Yams"),
      ]
    ),
    .testTarget(
      name: "ServiceLogosCLIForMacOSTest",
      dependencies: [
        "ServiceLogosCLIForMacOS",
        //        "Testing",
        .product(name: "Testing", package: "swift-testing"),
      ]
    ),
  ]
)
