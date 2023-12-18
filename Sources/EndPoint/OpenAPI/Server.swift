// Generated by swift-openapi-generator, do not modify.
@_spi(Generated) import OpenAPIRuntime
#if os(Linux)
@preconcurrency import struct Foundation.URL
@preconcurrency import struct Foundation.Data
@preconcurrency import struct Foundation.Date
#else
import struct Foundation.URL
import struct Foundation.Data
import struct Foundation.Date
#endif
import HTTPTypes
extension APIProtocol {
    /// Registers each operation handler with the provided transport.
    /// - Parameters:
    ///   - transport: A transport to which to register the operation handlers.
    ///   - serverURL: A URL used to determine the path prefix for registered
    ///   request handlers.
    ///   - configuration: A set of configuration values for the server.
    ///   - middlewares: A list of middlewares to call before the handler.
    internal func registerHandlers(
        on transport: any ServerTransport,
        serverURL: Foundation.URL = .defaultOpenAPIServerURL,
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
            {
                try await server.post_hyphen_my_hyphen_fortune(
                    request: $0,
                    body: $1,
                    metadata: $2
                )
            },
            method: .post,
            path: server.apiPathComponentsWithServerPrefix("/my_fortune")
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
    func post_hyphen_my_hyphen_fortune(
        request: HTTPTypes.HTTPRequest,
        body: OpenAPIRuntime.HTTPBody?,
        metadata: OpenAPIRuntime.ServerRequestMetadata
    ) async throws -> (HTTPTypes.HTTPResponse, OpenAPIRuntime.HTTPBody?) {
        try await handle(
            request: request,
            requestBody: body,
            metadata: metadata,
            forOperation: Operations.post_hyphen_my_hyphen_fortune.id,
            using: {
                APIHandler.post_hyphen_my_hyphen_fortune($0)
            },
            deserializer: { request, requestBody, metadata in
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
                let chosenContentType = try converter.bestContentType(
                    received: contentType,
                    options: [
                        "application/json"
                    ]
                )
                switch chosenContentType {
                case "application/json":
                    body = try await converter.getRequiredRequestBodyAsJSON(
                        Components.Schemas.MyFortuneRequest.self,
                        from: requestBody,
                        transforming: { value in
                            .json(value)
                        }
                    )
                default:
                    preconditionFailure("bestContentType chose an invalid content type.")
                }
                return Operations.post_hyphen_my_hyphen_fortune.Input(
                    headers: headers,
                    body: body
                )
            },
            serializer: { output, request in
                switch output {
                case let .ok(value):
                    suppressUnusedWarning(value)
                    var response = HTTPTypes.HTTPResponse(soar_statusCode: 200)
                    suppressMutabilityWarning(&response)
                    let body: OpenAPIRuntime.HTTPBody
                    switch value.body {
                    case let .json(value):
                        try converter.validateAcceptIfPresent(
                            "application/json",
                            in: request.headerFields
                        )
                        body = try converter.setResponseBodyAsJSON(
                            value,
                            headerFields: &response.headerFields,
                            contentType: "application/json; charset=utf-8"
                        )
                    }
                    return (response, body)
                case let .undocumented(statusCode, _):
                    return (.init(soar_statusCode: statusCode), nil)
                }
            }
        )
    }
}
