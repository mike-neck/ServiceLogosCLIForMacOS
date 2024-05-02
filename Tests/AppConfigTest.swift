import ServiceLogosCLIForMacOS
import Testing

struct AppConfigTest {
  @Test func codeGenerated() {
    let appConfig = AppConfig.main
    #expect(appConfig.name == "service-logos")
  }

  @Test func version() throws {
    let appConfig = AppConfig.main
    let version: String = appConfig.version
    let pattern = try Regex("^v\\d+\\.\\d+\\.\\d+$")
    let match = try #require(version.matches(of: pattern))
    #expect(match.count == 1)
    let result: Range<String.Index> = try #require(match.first).range
    #expect(
      result == version.allRange,
      "test version actual: \(result) expect: \(version.allRange)  \(#file):\(#line)"
    )
  }
}

extension String {
  var allRange: Range<String.Index> {
    let min = self.startIndex
    let max = self.endIndex
    return min..<max
  }
}
