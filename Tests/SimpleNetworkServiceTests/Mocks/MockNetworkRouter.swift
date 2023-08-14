//
//  File.swift
//

import Foundation
@testable import SimpleNetworkService

enum MockNetworkRouter: SimpleNetworkRouter {
    var path: String { "/test" }
    var method: HTTPMethod { .GET }
    var headers: [String : String]? {  nil}
    var query: [String : Any]? { nil }
    var body: Encodable? { nil }
}
