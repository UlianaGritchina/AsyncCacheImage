//
//  File.swift
//  AsyncCacheImage
//
//  Created by Ульяна Гритчина on 15.07.2026.
//

import Foundation

public final class AsyncCacheImageDependencies {
    let imagePipeline: ImagePipeline
    
    public init(imagePipeline: ImagePipeline) {
        self.imagePipeline = imagePipeline
    }
}

extension AsyncCacheImageDependencies {
    @MainActor public static let live = AsyncCacheImageDependencies(
        imagePipeline: ImagePipelineImpl(
            memoryCache: DefaultMemoryCache(),
            networkLoader: NetworkImageLoaderImpl()
        )
    )
}
