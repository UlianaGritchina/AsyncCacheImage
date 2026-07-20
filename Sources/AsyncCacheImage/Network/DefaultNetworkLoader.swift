//
//  DefaultNetworkLoader.swift
//  AsyncCacheImage
//
//  Created by Ульяна Гритчина on 13.07.2026.
//

import Foundation

final class DefaultNetworkLoader: NetworkLoader {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func data(from url: URL) async throws -> Data {
        let (data, response) = try await session.data(from: url)
        try checkResponse(response)
        return data
    }
    
    private func checkResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkLoaderError.invalidResponse
        }
        
        guard HTTPStatusCode.success.contains(httpResponse.statusCode) else {
            throw NetworkLoaderError.httpError(statusCode: httpResponse.statusCode)
        }
    }
}
