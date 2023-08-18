//
//  SimpleNetworkService.swift
//

import Foundation

public final class SimpleNetworkService: SimpleNetworkServiceProtocol {
    // Dependencies
    private let configuration: SimpleNetworkServiceConfiguration
    private let urlSession: URLSession
    private let dataParser: SimpleDataParserProtocol

    // Initializer

    public init(
        configuration: SimpleNetworkServiceConfiguration,
        urlSession: URLSession = .shared
    ) {
        self.configuration = configuration
        self.urlSession = urlSession
        self.dataParser = SimpleDataParser()
    }

    // MARK: - SimpleNetworkServiceProtocol

    public func executeRequest<T: Codable>(withRouter router: SimpleNetworkRouter) async throws -> T {
        guard let request = router.buildRequest(baseUrl: configuration.baseUrl) else {
            throw SimpleNetworkError.pathError(configuration.baseUrl)
        }
        do {
            let (data, _) = try await urlSession.data(for: request)
            let decodedData = try dataParser.decodeJSON(type: T.self, from: data)
            return decodedData
        } catch let error as URLError {
            throw SimpleNetworkError.requestFailed(error)
        } catch let error {
            throw SimpleNetworkError.decodingFailed(error)
        } 
    }
}
