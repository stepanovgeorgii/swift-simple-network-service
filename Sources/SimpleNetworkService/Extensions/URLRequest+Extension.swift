//
//  URLRequest+Extension.swift
//  

import Foundation

extension URLRequest {
    // MARK: - Factory initializer

    static func build(withQuery query: [String: Any]?, forURL url: URL) -> URLRequest {
        let request = URLRequest(url: url)

        guard
            let query,
            let queryItems = queryItems(by: query as? [String: CustomStringConvertible]),
            var components = URLComponents(string: url.absoluteString)
        else {
            return request
        }

        components.queryItems = queryItems

        guard let urlWithParams = components.url else {
            return request
        }

        return URLRequest(url: urlWithParams)
    }

    // MARK: - Private

    private static func queryItems(by parameters: [String: CustomStringConvertible]?) -> [URLQueryItem]? {
        parameters?.filter { !($0.value is Data) }.compactMap {
            URLQueryItem(name: $0.key, value: $0.value.description)
        }
    }

    // MARK: - Configurations

    func set(httpMethod: HTTPMethod) -> Self {
        var request = self
        request.httpMethod = httpMethod.rawValue
        return request
    }

    func set(headers: [String: String]?) -> Self {
        guard let headers else { return self }
        var request = self
        headers.forEach { request.addValue($0.value, forHTTPHeaderField: $0.key) }
        return request
    }

    func set(body: Encodable?) -> Self {
        guard
            let body,
            let bodyData = try? JSONEncoder().encode(body)
        else {
            return self
        }
        var request = self
        request.httpBody = bodyData
        return request
    }
}
