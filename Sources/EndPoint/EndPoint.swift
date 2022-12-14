import Compute
import FakeFortuneTelling
import Foundation

@main
struct EndPoint {
    
    public static func main() async throws {
        try await onIncomingRequest(router.run)
    }
    
    private static let apiVersionHeaderKey = "API-Version"
    private static let indexPath = ""
    private static let myFortunePath = "my_fortune"
    
    static let router = Router()
        .get(indexPath, handleIndexRoute(request:response:))
        .post(myFortunePath, handleFortuneRoute(request:response:))
    
}

extension EndPoint {
    
    static func handleIndexRoute(request: IncomingRequest, response: OutgoingResponse) async throws {
        
        try await response
            .status(.ok)
            .send(html: Index().html)
        
    }
    
    static func handleFortuneRoute(request: IncomingRequest, response: OutgoingResponse) async throws {
        
        let version = try APIVersion(versionString: request.headers[apiVersionHeaderKey]) ?? .v1
        
        switch version {
        case .v1:
            let result = try await askFortune(from: request)
            try await response
                .status(.ok)
                .send(result)
        }
        
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
        let prefecture = FortuneTeller.prefectureForYou(
            name: info.name,
            birthday: info.birthday,
            bloodType: info.bloodType,
            today: info.today
        )
        let result = ReturningInfo(prefecture: prefecture)
        let encoded = try jsonEncoder.encode(result)
        
        return encoded
        
    }
    
}

private struct ProvidedInfo: Decodable {
    
    let name: Name
    let bloodType: BloodType
    let birthday: YearMonthDay
    let today: YearMonthDay
    
}

private struct ReturningInfo: Encodable {
    
    let name: String
    let capital: String
    let brief: String
    
    init(prefecture: Prefecture) {
        self.name = prefecture.name
        self.capital = prefecture.capital
        self.brief = prefecture.brief
    }
    
}
