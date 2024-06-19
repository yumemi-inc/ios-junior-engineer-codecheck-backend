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
    case unknown
}

/// API の品質を表現します。
enum APIQuality {
    case sometimesFails(probability: Double)
    case alwaysFails
    case neverFails

    func test() -> Bool {
        return switch self {
        case .sometimesFails(let probability):
            shouldFail(probability: probability)
        case .alwaysFails:
            true
        case .neverFails:
            false
        }
    }

    private func shouldFail(probability: Double) -> Bool {
        return (0 ..< probability).contains(Double.random(in: 0 ..< 1))
    }
}

struct APIController: APIProtocol {

    /// API の想定品質
    var apiQuality: APIQuality?

    func post_hyphen_my_hyphen_fortune(_ input: Operations.post_hyphen_my_hyphen_fortune.Input) async throws -> Operations.post_hyphen_my_hyphen_fortune.Output {

        if let apiQuality, apiQuality.test() {
            throw APIServiceError.unknown
        }

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
        let birthday = body.birthday.value1
        let today = body.today.value1
        let result = try FortuneTeller.prefectureForYou(
            name: .init(text: body.name),
            birthday: .init(year: birthday.year, month: birthday.month, day: birthday.day),
            bloodType: .init(body.blood_type),
            today: .init(year: today.year, month: today.month, day: today.day))
        return .ok(.init(body: .json(.init(
            name: result.name,
            brief: result.brief,
            capital: result.capital,
            citizen_day: result.citizenDay.map { .init(value1: .init(month: $0.month, day: $0.day)) },
            has_coast_line: result.hasCoastLine,
            logo_url: result.logoURL?.absoluteString ?? ""))))
    }
}

extension BloodType {
    init(_ input: Components.Schemas.MyFortuneRequest.blood_typePayload) {
        switch input {
        case .a: self = .a
        case .b: self = .b
        case .ab: self = .ab
        case .o: self = .o
        }
    }
}

extension Prefecture {
    var logoURL: URL? {
        let name = switch self {
            case .gunma: "gumma"
            default: "\(self)"
        }
        return .init(string: "https://japan-map.com/wp-content/uploads/\(name).png")
    }
}
