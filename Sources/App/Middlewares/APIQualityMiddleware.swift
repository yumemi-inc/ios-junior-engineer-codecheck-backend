//
//  File.swift
//
//
//  Created by 古宮 伸久 on 2024/06/20.
//

import Vapor

/// API の品質を表現します。
enum APIQuality: Sendable {
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

final class APIQualityMiddleware: Middleware, Sendable {

    let apiQuality: APIQuality
    let onError: Error

    init(apiQuality: APIQuality, onError: Error) {
        self.apiQuality = apiQuality
        self.onError = onError
    }
    
    func respond(to request: Vapor.Request, chainingTo next: any Vapor.Responder) -> NIOCore.EventLoopFuture<Vapor.Response> {
        if apiQuality.test() {
            request.eventLoop.makeFailedFuture(onError)
        } else {
            next.respond(to: request)
        }
    }
}
