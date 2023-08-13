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
    var baseUrlString: NSString {
        return NSString(string: "")
    }

    var request: URLRequest? {
        guard let url = URL(string: fullUrlString) else { return nil }
        var request: URLRequest
        if let query {
            var components = URLComponents(string: url.absoluteString)
            components?.queryItems = queryItems(by: query as? [String: CustomStringConvertible])
            let urlWithParams = components?.url
            request = URLRequest(url: urlWithParams ?? url)
        } else {
            request = URLRequest(url: url)
        }
        request.httpMethod = method.rawValue
        defaultHeaders.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        if let headers {
            headers.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        }
        request.httpBody = body?.data
        return request
    }
}

// MARK: - Private

private extension SimpleNetworkRouter {
    var fullUrlString: String {
        return baseUrlString.appendingPathComponent(path)
    }

    var defaultHeaders: [String: String] {
        return [
            "Content-Type": "application/json",
            "accept": "*/*"
        ]
    }

    func queryItems(
        by parameters: [String: CustomStringConvertible]?
    ) -> [URLQueryItem]? {
        parameters?.filter {
            !($0.value is Data)
        }.compactMap {
            URLQueryItem(
                name: $0.key,
                value: $0.value.description
            )
        }
    }
}

private extension Encodable {
    var data: Data? {
        return try? JSONEncoder().encode(self)
    }
}
