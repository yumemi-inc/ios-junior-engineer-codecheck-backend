import Compute
import FakeFortuneTelling
import Foundation

@main
struct EndPoint {
    
    public static func main() async throws {
        try await onIncomingRequest(router.run)
    }
    
    static let router = Router()
        .get("") { req, res in
            try await res
                .status(.ok)
                .send("Hello, World!")
        }
        .get("/my_fortune") { req, res in
            let result = try await askFortune(from: req)
            try await res
                .status(.ok)
                .send(result)
        }
    
}

extension EndPoint {
    
    private static let jsonDecoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
        return decoder
    }()
    
    private static let jsonEncoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.keyEncodingStrategy = .convertToSnakeCase
        return encoder
    }()
    
    static func askFortune(from request: IncomingRequest) async throws -> Data {
        
        let info = try await request.body.decode(ProvidedInfo.self, decoder: jsonDecoder)
        let fortune = FortuneTeller.fortuneForYou(
            name: info.name,
            birthday: info.birthday,
            bloodType: info.bloodType,
            today: info.today
        )
        let encoded = try jsonEncoder.encode(fortune)
        
        return encoded
        
    }
    
}

private struct ProvidedInfo: Decodable {
    
    let name: Name
    let bloodType: BloodType
    let birthday: YearMonthDay
    let today: YearMonthDay
    
}
