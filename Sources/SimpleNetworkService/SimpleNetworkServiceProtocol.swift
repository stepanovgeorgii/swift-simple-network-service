//
//  NetworkServiceProtocol.swift
//

public protocol SimpleNetworkServiceProtocol: AnyObject {
    func request<T: Codable>(router: SimpleNetworkRouter) async throws -> T
}
