import Vapor
import OpenAPIVapor

// configures your application
public func configure(_ app: Application) async throws {
    // uncomment to serve files from /Public folder
    app.middleware.use(
        FileMiddleware(publicDirectory: app.directory.publicDirectory, defaultFile: "index.html")
    )
    // register routes
    let transport = VaporTransport(routesBuilder: app)
    let controller = APIController()
    try controller.registerHandlers(on: transport)
}
