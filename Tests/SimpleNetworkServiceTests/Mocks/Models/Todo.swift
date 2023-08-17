//
//  Todo.swift
//  

import Foundation

struct Todo: Codable, Equatable {
    let userId: Int
    let id: Int
    let title: String
    let completed: Bool
}
