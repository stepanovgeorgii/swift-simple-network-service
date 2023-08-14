//
//  SimpleNetworkRouter.swift
//

import Foundation

public protocol SimpleNetworkRouter {
    var baseUrlString: NSString { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var query: [String: Any]? { get }
    var body: Encodable? { get }
    var request: URLRequest? { get }
}

public extension SimpleNetworkRouter {
    var baseUrlString: NSString { return NSString(string: "") }

    var request: URLRequest? {
        guard let url = URL(string: fullUrlString) else { return nil }
        return URLRequest.build(withQuery: query, forURL: url)
            .set(httpMethod: method)
            .set(headers: defaultHeaders)
            .set(headers: headers)
            .set(body: body)
    }
}

// MARK: - Private

private extension SimpleNetworkRouter {
    var fullUrlString: String { return baseUrlString.appendingPathComponent(path) }

    var defaultHeaders: [String: String] {
        return [
            "Content-Type": "application/json",
            "accept": "*/*"
        ]
    }
}
