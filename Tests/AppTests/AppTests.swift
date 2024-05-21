@testable import App
import XCTVapor

final class AppTests: XCTestCase {
    var app: Application!

    override func setUp() async throws {
        self.app = try await Application.make(.testing)
        try await configure(app)
    }

    override func tearDown() async throws {
        try await self.app.asyncShutdown()
        self.app = nil
    }

    func testMyFortune() throws {
        try self.app.test(
            .POST,
            "/my_fortune",
            headers: ["API-Version": "v1"],
            beforeRequest: { req in
                let content = Components.Schemas.MyFortuneRequest(
                    name: "ゆめみん",
                    birthday: .init(value1: .init(year: 2000, month: 1, day: 27)),
                    blood_type: .ab,
                    today: .init(value1: .init(year: 2023, month: 5, day: 7)))
                try req.content.encode(content)
            },
            afterResponse: { res in
                XCTAssertEqual(res.status, .ok)
                let result = try res.content.decode(Components.Schemas.MyFortuneResponse.self)
                XCTAssertEqual(result.name, "埼玉県")
                XCTAssertEqual(result.brief, "埼玉県（さいたまけん）は、日本の関東地方に位置する県。県庁所在地はさいたま市。\n※出典: フリー百科事典『ウィキペディア（Wikipedia）』")
                XCTAssertEqual(result.capital, "さいたま市")
                let citizenDay = try XCTUnwrap(result.citizen_day?.value1)
                XCTAssertEqual(citizenDay.month, 11)
                XCTAssertEqual(citizenDay.day, 14)
                XCTAssertEqual(result.has_coast_line, false)
                XCTAssertEqual(result.logo_url, "https://japan-map.com/wp-content/uploads/saitama.png")
            }
        )
    }
}

extension Components.Schemas.MyFortuneRequest: Content {}
extension Components.Schemas.MyFortuneResponse: Content {}
