//
//  PostsRouter.swift
//

import Foundation
@testable import SimpleNetworkService

enum PostsRouter: SimpleNetworkRouter {
    case savePost(Post)

    var path: String {
        switch self {
        case .savePost:
            return "/posts"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .savePost:
            return .POST
        }
    }

    var headers: [String : String]? { nil }
    var query: [String : Any]? { nil }
    
    var body: Encodable? {
        switch self {
        case .savePost(let post):
            return post
        }
    }
}
