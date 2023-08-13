//
//  NetworkError.swift
//
//  Created by Georgy Stepanov on 13.08.2023.
//

import Foundation

public enum SimpleNetworkError: LocalizedError {
    case invalidURLRequest(path: String)
    case requestFailed(Error)
    case decodingFailed(Error)

    public var errorDescription: String? {
        switch self {
        case .invalidURLRequest(let path):
            return "NetworkService error: Invalid URL request for the path: \(path)"
        case .requestFailed(let error):
            return "NetworkService error: Request failed: \(error.localizedDescription)"
        case .decodingFailed(let error):
            return "NetworkService error: Decoding failed: \(error.localizedDescription)"
        }
    }
}
