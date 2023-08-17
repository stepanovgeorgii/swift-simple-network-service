//
//  SimpleNetworkError.swift
//

import Foundation

public enum SimpleNetworkError: LocalizedError {
    case pathError(String)
    case requestFailed(Error)
    case decodingFailed(Error)

    public var errorDescription: String? {
        switch self {
        case .pathError(let message):
            return "NetworkService error: Path not valid: \(message)"
        case .requestFailed(let error):
            return "NetworkService error: Request failed: \(error.localizedDescription)"
        case .decodingFailed(let error):
            return "NetworkService error: Decoding failed: \(error.localizedDescription)"
        }
    }
}
