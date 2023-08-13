//
//  NetworkService.swift
//

import Foundation

public final class SimpleNetworkService: SimpleNetworkServiceProtocol {
    private let urlSession: URLSession
    private let dataParser: SimpleDataParserProtocol

    public init(
        urlSession: URLSession = .shared
    ) {
        self.urlSession = urlSession
        self.dataParser = SimpleDataParser()
    }

    public func request<T: Codable>(router: SimpleNetworkRouter) async throws -> T {
        guard let request = router.request else {
            throw SimpleNetworkError.invalidURLRequest(path: router.path)
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
