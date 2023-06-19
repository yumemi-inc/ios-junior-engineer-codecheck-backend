//
//  File.swift
//  
//
//  Created by 古宮 伸久 on 2023/06/19.
//

import Compute
import FakeFortuneTelling

enum APIServiceError: Error {
    case InvalidateInput
}

struct APIService : APIProtocol {

    init(router: Router) {
        router.get("", handleIndexRoute(request:response:))
    }

    func handleIndexRoute(request: IncomingRequest, response: OutgoingResponse) async throws {
        try await response
            .status(.ok)
            .send(html: Index().html)
    }

    func post_my_fortune(_ input: Operations.post_my_fortune.Input) async throws -> Operations.post_my_fortune.Output {
        let version = input.headers.API_Version ?? .v1
        switch version {
        case .v1:
            return try await askFortune(input)

        case .undocumented(_):
            throw APIServiceError.InvalidateInput
        }
    }

    private func askFortune(_ input: Operations.post_my_fortune.Input) async throws -> Operations.post_my_fortune.Output {
        guard case let .json(body) = input.body else {
            throw APIServiceError.InvalidateInput
        }
        let result = try FortuneTeller.prefectureForYou(
            name: .init(body.name),
            birthday: .init(body.birthday),
            bloodType: .init(body.blood_type),
            today: .init(body.today))
        return .ok(.init(body: .json(.init(
            name: result.name,
            brief: result.brief,
            capital: result.capital,
            has_coast_line: result.hasCoastLine,
            logo_url: result.logoURL.absoluteString))))
    }
}

extension Name {
    init(_ input: String) throws {
        try self.init(text: input)
    }
}
extension BloodType {
    init(_ input: Components.Schemas.MyFortuneRequest.blood_typePayload) throws {
        switch input {
        case .a: self = .a
        case .b: self = .b
        case .ab: self = .ab
        case .o: self = .o
        case .undocumented(_):
            throw APIServiceError.InvalidateInput
        }
    }
}

extension YearMonthDay {
    init(_ input: Components.Schemas.YearMonthDay) throws {
        try self.init(year: input.year, month: input.month, day: input.day)
    }
}
