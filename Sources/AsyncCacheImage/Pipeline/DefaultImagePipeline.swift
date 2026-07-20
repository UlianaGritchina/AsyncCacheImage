//
//  ImagePipelineImpl.swift
//  AsyncCacheImage
//
//  Created by Ульяна Гритчина on 13.07.2026.
//

import Foundation

final class DefaultImagePipeline: ImagePipeline {
    let memoryCache: CacheService
    let diskCache: CacheService
    let networkLoader: NetworkLoader
    
    public init(
        memoryCache: CacheService,
        diskCache: CacheService,
        networkLoader: NetworkLoader
    ) {
        self.memoryCache = memoryCache
        self.diskCache = diskCache
        self.networkLoader = networkLoader
    }
    
    func getImageData(for url: URL) async throws -> Data {
        let cacheKey = url.absoluteString
        
        if let memoryCachedImageData = try? await memoryCache.get(from: cacheKey) {
            return memoryCachedImageData
        }
        
        if let diskCachedImageData = try? await diskCache.get(from: cacheKey) {
            return diskCachedImageData
        }
        
        let imageData = try await networkLoader.data(from: url)
        
        try? await memoryCache.save(data: imageData, for: cacheKey)
        try? await diskCache.save(data: imageData, for: cacheKey)
        
        return imageData
    }
}
