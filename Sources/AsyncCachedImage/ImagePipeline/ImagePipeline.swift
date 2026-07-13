//
//  ImagePipeline.swift
//  AsyncCachedImage
//
//  Created by Ульяна Гритчина on 13.07.2026.
//

import Foundation

protocol ImagePipeline: Sendable {
    func getImageData(for url: URL) async throws -> Data
}

final class ImagePipelineImpl: ImagePipeline {
    
    let memoryCache: MemoryCacheService
    let networkImageLoader: NetworkImageLoader
    
    init(memoryCache: MemoryCacheService, networkImageLoader: NetworkImageLoader) {
        self.memoryCache = memoryCache
        self.networkImageLoader = networkImageLoader
    }
    
    func getImageData(for url: URL) async throws -> Data {
        let cacheKey = url.absoluteString
        
        if let cachedImageData = memoryCache.get(key: cacheKey) {
            return cachedImageData
        }
        
        let imageData = try await networkImageLoader.data(from: url)
        
        return imageData
    }
}
