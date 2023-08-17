//
//  SimpleNetworkService.swift
//

import Foundation

public final class SimpleNetworkService: SimpleNetworkServiceProtocol {
    private let configuration: SimpleNetworkServiceConfiguration
    private let urlSession: URLSession
    private let dataParser: SimpleDataParserProtocol

    public init(
        configurator: SimpleNetworkServiceConfiguration,
        urlSession: URLSession = .shared
    ) {
        self.configuration = configurator
        self.urlSession = urlSession
        self.dataParser = SimpleDataParser()
    }

    public func request<T: Codable>(router: SimpleNetworkRouter) async throws -> T {
        guard let request = try router.request(baseUrl: configuration.baseUrl) else {
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
