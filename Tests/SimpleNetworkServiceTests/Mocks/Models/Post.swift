//
//  Post.swift
//

import Foundation

struct Post: Codable, Equatable {
    let title: String
    let body: String
    let userId: Int
}

struct PostResponse: Codable, Equatable {
    let id: Int
    let title: String
    let body: String
    let userId: Int
}
