//
//  File.swift
//  AsyncCachedImage
//
//  Created by Ульяна Гритчина on 13.07.2026.
//

import Foundation

protocol NetworkImageLoader: Sendable {
    func data(from url: URL) async throws -> Data
}

final class NetworkImageLoaderImpl: NetworkImageLoader {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func data(from url: URL) async throws -> Data {
        let (data, response) = try await session.data(
            from: url
        )
        
        guard let httpResponse = response as? HTTPURLResponse else {
            throw ImageLoaderError.invalidResponse
        }
        
        guard (200...299).contains(httpResponse.statusCode) else {
            throw ImageLoaderError.httpError(
                statusCode: httpResponse.statusCode
            )
        }
        return data
    }
}


