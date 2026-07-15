//
//  ImagePipelineImpl.swift
//  AsyncCachedImage
//
//  Created by Ульяна Гритчина on 13.07.2026.
//

import Foundation

final class ImagePipelineImpl: ImagePipeline {
    
    let memoryCache: MemoryCacheService
    let networkLoader: NetworkLoader
    
    public init(
        memoryCache: MemoryCacheService,
        networkLoader: NetworkLoader
    ) {
        self.memoryCache = memoryCache
        self.networkLoader = networkLoader
    }
    
    func getImageData(for url: URL) async throws -> Data {
        let cacheKey = url.absoluteString
        
        if let cachedImageData = await memoryCache.get(key: cacheKey) {
            return cachedImageData
        }
        
        let imageData = try await networkLoader.data(from: url)
        
        await memoryCache.save(data: imageData, for: cacheKey)
        
        return imageData
    }
}
