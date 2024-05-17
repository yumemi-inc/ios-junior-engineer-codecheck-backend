//
//  APIController.swift
//
//
//  Created by 古宮 伸久 on 2024/05/16.
//

import Foundation
import FakeFortuneTelling

enum APIServiceError: Error {
    case InvalidateInput
}

struct APIController: APIProtocol {
    func post_hyphen_my_hyphen_fortune(_ input: Operations.post_hyphen_my_hyphen_fortune.Input) async throws -> Operations.post_hyphen_my_hyphen_fortune.Output {
        let version = input.headers.API_hyphen_Version ?? .v1
        switch version {
        case .v1:
            return try await askFortune(input)
        }
    }

    private func askFortune(_ input: Operations.post_hyphen_my_hyphen_fortune.Input) async throws -> Operations.post_hyphen_my_hyphen_fortune.Output {
        guard case let .json(body) = input.body else {
            throw APIServiceError.InvalidateInput
        }
        let result = try FortuneTeller.prefectureForYou(
            name: .init(body.name),
            birthday: .init(body.birthday.value1),
            bloodType: .init(body.blood_type),
            today: .init(body.today.value1))
        return .ok(.init(body: .json(.init(
            name: result.name,
            brief: result.brief,
            capital: result.capital,
            has_coast_line: result.hasCoastLine,
            logo_url: result.logoURL?.absoluteString ?? ""))))
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
        }
    }
}

extension YearMonthDay {
    init(_ input: Components.Schemas.YearMonthDay) throws {
        try self.init(year: input.year, month: input.month, day: input.day)
    }
}

extension Prefecture {
    private var spell: String {
        switch self {
        case .gunma:
            return "gumma"
            
        default:
            return "\(self)"
        }
    }
    
    var logoURL: URL? {
        .init(string: "https://japan-map.com/wp-content/uploads/\(spell).png")
    }
}
