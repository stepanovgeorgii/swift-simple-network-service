//
//  TodosRouter.swift
//

import Foundation
@testable import SimpleNetworkService

enum TodosRouter: SimpleNetworkRouter {
    case todos
    case todo(id: Int)

    var path: String {
        switch self {
        case .todos:
            return "/todos"
        case .todo(let id):
            return "/todos/\(id)"
        }
    }

    var method: HTTPMethod { .GET }
    var headers: [String : String]? { nil }
    var query: [String : Any]? { nil }
    var body: Encodable? { nil }
}
