//
//  ImagePipelineImpl.swift
//  AsyncCacheImage
//
//  Created by Ульяна Гритчина on 13.07.2026.
//

import Foundation

final class DefaultImagePipeline: ImagePipeline {
    
    let memoryCache: MemoryCacheService
    let diskCache: DiskCache
    let networkLoader: NetworkLoader
    
    public init(
        memoryCache: MemoryCacheService,
        diskCache: DiskCache,
        networkLoader: NetworkLoader
    ) {
        self.memoryCache = memoryCache
        self.diskCache = diskCache
        self.networkLoader = networkLoader
    }
    
    func getImageData(for url: URL) async throws -> Data {
        let cacheKey = url.absoluteString
        
        if let memoryCachedImageData = await memoryCache.get(key: cacheKey) {
            return memoryCachedImageData
        }
        
        if let diskCachedImageData = try await diskCache.getData(key: cacheKey) {
            return diskCachedImageData
        }
        
        let imageData = try await networkLoader.data(from: url)
        
        await memoryCache.save(data: imageData, for: cacheKey)
        
        return imageData
    }
}
