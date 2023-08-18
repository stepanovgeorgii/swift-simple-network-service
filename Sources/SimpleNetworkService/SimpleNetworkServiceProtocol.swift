//
//  NetworkServiceProtocol.swift
//

public protocol SimpleNetworkServiceProtocol: AnyObject {
    func executeRequest<T: Codable>(withRouter router: SimpleNetworkRouter) async throws -> T
}
