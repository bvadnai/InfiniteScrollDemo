//
//  ApiError.swift
//  InfiniteScrollDemo
//
//  Created by Balazs Vadnai on 2020. 10. 23..
//

import Foundation

enum ApiError: Error {
    case noInternetConnection
    case requestFailure(String)
    case badResponseFormat
    case unauthorized
}

extension ApiError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noInternetConnection:
            return "No internet connection."
        case .requestFailure(let apiMessage):
            return apiMessage
        case .unauthorized:
            return "Invalid credentials."
        case .badResponseFormat:
            return "Error communicating with the server."
        }
    }
}
