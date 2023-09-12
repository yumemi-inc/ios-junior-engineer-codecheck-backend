import Foundation
import Compute
import FakeFortuneTelling
import OpenAPICompute

@main
struct EndPoint {
    public static func main() async throws {
        let service: APIProtocol = APIService(router: router)
        try service.registerHandlers(on: ComputeTransport(router: router))

        try await onIncomingRequest(router.run)
    }

    static let router = Router()
}

extension EndPoint {
    
    static func handleIndexRoute(request: IncomingRequest, response: OutgoingResponse) async throws {
        try await response
            .status(.ok)
            .send(html: Index().html)
    }
}
