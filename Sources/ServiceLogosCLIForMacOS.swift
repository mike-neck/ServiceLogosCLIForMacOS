// The Swift Programming Language
// https://docs.swift.org/swift-book
//
// Swift Argument Parser
// https://swiftpackageindex.com/apple/swift-argument-parser/documentation

import ArgumentParser
import Foundation
import Yams

@main
struct ServiceLogosCLIForMacOS: ParsableCommand {

  @OptionGroup var sharedOptions: SharedOptions

  static var configuration: CommandConfiguration {
    let appConfig = AppConfig.main
    return CommandConfiguration(
      commandName: appConfig.name,
      abstract: "",
      usage: "",
      version: appConfig.version,
      shouldDisplay: true,
      subcommands: [
        ListSubCommand.self
      ],
      defaultSubcommand: ListSubCommand.self,
      helpNames: [
        .customLong("help"),
        .customShort("h"),
      ]
    )
  }
}

struct SharedOptions: ParsableArguments {

  @Option(
    name: [
      .customLong("config-path"),
      .customLong("config"),
      .customShort("c"),
    ],
    help: ArgumentHelp(
      stringLiteral:
        "specifies a service-logos config file. The format of the config file is YAML. The default of this option is <HOME>/.config/service-logos/config.yml"
    )
  )
  public var configPath: String? = nil
}

let API_KEY_ENV_NAME: String = "SL_GITHUB_TOKEN"
let CONFIG_PATH: String = "./config/service-logos/config.yml"

@available(macOS 14.0, *)
extension SharedOptions {

  public var apiKey: String? {
    let pinfo = ProcessInfo.processInfo
    if let foundKey = pinfo.environment[API_KEY_ENV_NAME] {
      return foundKey
    }

    let home = NSHomeDirectory()
    let configFilePath = "\(home)/\(configPath ?? CONFIG_PATH)"
    let yamlDecoder = YAMLDecoder()
    do {
      let sessionConfig = try yamlDecoder.decode(SessionConfig.self, fromFile: configFilePath)
      return sessionConfig.apiToken
    } catch {
      return nil
    }
  }
}

struct SessionConfig: Decodable {
  var apiToken: String?
}

@available(macOS 14.0, *)
extension YAMLDecoder {
  func decode<T>(
    _ type: T.Type = T.self,
    fromFile yaml: String,
    userInfo: [CodingUserInfoKey: Any] = [:]
  ) throws -> T where T: Swift.Decodable {
    let fileUrl = URL(filePath: yaml)
    let data = try Data(contentsOf: fileUrl)
    return try decode(type, from: data, userInfo: userInfo)
  }
}
