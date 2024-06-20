import Vapor
import OpenAPIVapor

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    app.middleware.use(
        FileMiddleware(publicDirectory: app.directory.publicDirectory, defaultFile: "index.html")
    )
    app.middleware.use(
        APIQualityMiddleware(apiQuality: .sometimesFails(probability: 0.25), onError: APIServiceError.unknown)
    )
    // register routes
    let transport = VaporTransport(routesBuilder: app)
    let controller = APIController()
    try controller.registerHandlers(on: transport)
}
