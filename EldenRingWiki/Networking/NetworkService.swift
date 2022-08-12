//
//  NetworkService.swift
//  EldenRingWiki
//
//  Created by Dmitrii Shliugaev on 12/08/2022.
//

import Foundation

protocol NetworkServiceProtocol {
    func load<T>(endpoint: Endpoint) async throws -> T
}

class NetworkService {
    private let session: URLSession
    private let decoder: JSONDecoder
    
    init(session: URLSession = .shared,
         decoder: JSONDecoder = JSONDecoder()) {
        self.session = session
        self.decoder = decoder
    }
    
    func load<T: Decodable>(endpoint: Endpoint) async throws -> T {
        do {
            let (data, response) = try await session.data(for: endpoint.request)
            
            guard let response = response as? HTTPURLResponse else {
                throw NetworkError.invalidResponse
            }
            
            if response.statusCode == 401 {
                throw NetworkError.unauthenticated
            }
            
            if !response.hasSuccessStatusCode {
                throw NetworkError.custom(
                    errorCode: response.statusCode,
                    errorDescription: HTTPURLResponse.localizedString(forStatusCode: response.statusCode)
                )
            }
            return try decoder.decode(T.self, from: data)
            
        } catch {
            if let error = error as? NetworkError { throw error }
            
            let error = error as NSError
            if error.domain == NSURLErrorDomain,
               error.code == NSURLErrorNotConnectedToInternet {
                throw NetworkError.noInternet
            } else if let error = error as? DecodingError {
                throw NetworkError.parsing(error: error)
            } else {
                throw NetworkError.unknown(error: error)
            }
        }
    }
}
