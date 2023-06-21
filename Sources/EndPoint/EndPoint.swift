import Foundation
import Compute
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
