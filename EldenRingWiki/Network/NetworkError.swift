//
//  NetworkError.swift
//
//
//  Created by Dmitrii Shliugaev on 12/08/2022.
//

import Foundation

enum NetworkError {
    case invalidResponse
    case noInternet
    case unauthenticated
    case parsing(error: DecodingError)
    case custom(errorCode: Int?, errorDescription: String?)
    case unknown(error: Error?)
}

extension NetworkError: LocalizedError {
    var errorDescription: String? {
        switch self {
        case .noInternet: return "NetworkError.NoInternet".localizedString
        case .invalidResponse: return "NetworkError.InvalidResponse".localizedString
        case .unauthenticated: return "NetworkError.UnauthenticatedUser".localizedString
        case let .parsing(error): return "NetworkError.ParsingError".localizedString + error.localizedDescription
        case let .custom(_, errorDescription): return errorDescription
        case let .unknown(error): return "NetworkError.UnknownError".localizedString + (error?.localizedDescription ?? "")
        }
    }

    var errorCode: Int? {
        switch self {
        case .noInternet: return nil
        case .invalidResponse: return nil
        case .unauthenticated: return nil
        case .parsing: return nil
        case let .custom(errorCode, _): return errorCode
        case .unknown: return nil
        }
    }
}
