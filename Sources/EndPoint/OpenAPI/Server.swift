// Generated by swift-openapi-generator, do not modify.
@_spi(Generated) import OpenAPIRuntime
#if os(Linux)
@preconcurrency import Foundation
#else
import Foundation
#endif
extension APIProtocol {
    /// Registers each operation handler with the provided transport.
    /// - Parameters:
    ///   - transport: A transport to which to register the operation handlers.
    ///   - serverURL: A URL used to determine the path prefix for registered
    ///   request handlers.
    ///   - configuration: A set of configuration values for the server.
    ///   - middlewares: A list of middlewares to call before the handler.
    public func registerHandlers(
        on transport: any ServerTransport,
        serverURL: URL = .defaultOpenAPIServerURL,
        configuration: Configuration = .init(),
        middlewares: [any ServerMiddleware] = []
    ) throws {
        let server = UniversalServer(
            serverURL: serverURL,
            handler: self,
            configuration: configuration,
            middlewares: middlewares
        )
        try transport.register(
            { try await server.post_hyphen_my_hyphen_fortune(request: $0, metadata: $1) },
            method: .post,
            path: server.apiPathComponentsWithServerPrefix(["my_fortune"]),
            queryItemNames: []
        )
    }
}
fileprivate extension UniversalServer where APIHandler: APIProtocol {
    /// Get fortune for given person
    ///
    /// This endpoint returns the fortune of a person based on their name, birthday, and blood type, as well as the current date.
    ///
    /// - Remark: HTTP `POST /my_fortune`.
    /// - Remark: Generated from `#/paths//my_fortune/post(post-my-fortune)`.
    func post_hyphen_my_hyphen_fortune(request: Request, metadata: ServerRequestMetadata) async throws -> Response {
        try await handle(
            request: request,
            with: metadata,
            forOperation: Operations.post_hyphen_my_hyphen_fortune.id,
            using: { APIHandler.post_hyphen_my_hyphen_fortune($0) },
            deserializer: { request, metadata in
                let headers: Operations.post_hyphen_my_hyphen_fortune.Input.Headers = .init(
                    API_hyphen_Version: try converter.getOptionalHeaderFieldAsURI(
                        in: request.headerFields,
                        name: "API-Version",
                        as: Operations.post_hyphen_my_hyphen_fortune.Input.Headers.API_hyphen_VersionPayload.self
                    ),
                    accept: try converter.extractAcceptHeaderIfPresent(in: request.headerFields)
                )
                let contentType = converter.extractContentTypeIfPresent(in: request.headerFields)
                let body: Operations.post_hyphen_my_hyphen_fortune.Input.Body
                if try contentType == nil
                    || converter.isMatchingContentType(received: contentType, expectedRaw: "application/json")
                {
                    body = try converter.getRequiredRequestBodyAsJSON(
                        Components.Schemas.MyFortuneRequest.self,
                        from: request.body,
                        transforming: { value in .json(value) }
                    )
                } else {
                    throw converter.makeUnexpectedContentTypeError(contentType: contentType)
                }
                return Operations.post_hyphen_my_hyphen_fortune.Input(headers: headers, body: body)
            },
            serializer: { output, request in
                switch output {
                case let .ok(value):
                    suppressUnusedWarning(value)
                    var response = Response(statusCode: 200)
                    suppressMutabilityWarning(&response)
                    switch value.body {
                    case let .json(value):
                        try converter.validateAcceptIfPresent("application/json", in: request.headerFields)
                        response.body = try converter.setResponseBodyAsJSON(
                            value,
                            headerFields: &response.headerFields,
                            contentType: "application/json; charset=utf-8"
                        )
                    }
                    return response
                case let .undocumented(statusCode, _): return .init(statusCode: statusCode)
                }
            }
        )
    }
}
