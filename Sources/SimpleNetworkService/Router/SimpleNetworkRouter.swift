//
//  SimpleNetworkRouter.swift
//

import Foundation

public protocol SimpleNetworkRouter {
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var query: [String: Any]? { get }
    var body: Encodable? { get }

    func buildRequest(baseUrl: String) -> URLRequest?
}

public extension SimpleNetworkRouter {
    func buildRequest(baseUrl: String) -> URLRequest? {
        guard let url = URL(string: fullUrlString(with: baseUrl)) else {
            return nil
        }
        return URLRequest.build(withQuery: query, forURL: url)
            .set(httpMethod: method)
            .set(headers: defaultHeaders)
            .set(headers: headers)
            .set(body: body)
    }

    private func fullUrlString(with baseUrl: String) -> String {
        NSString(string: baseUrl).appendingPathComponent(path)
    }
}

// MARK: - Private

private extension SimpleNetworkRouter {
    var defaultHeaders: [String: String] {
        return [
            "Content-Type": "application/json",
            "accept": "*/*"
        ]
    }
}
