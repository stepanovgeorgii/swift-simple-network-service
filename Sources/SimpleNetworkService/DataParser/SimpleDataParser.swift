//
//  SimpleDataParser.swift
//

import Foundation

public protocol SimpleDataParserProtocol {
    func decodeJSON<T: Decodable>(type: T.Type, from data: Data) throws -> T
}

public struct SimpleDataParser: SimpleDataParserProtocol {
    private let decoder = JSONDecoder()

    public func decodeJSON<T: Decodable>(type: T.Type, from data: Data) throws -> T {
        return try JSONDecoder().decode(T.self, from: data)
    }
}
