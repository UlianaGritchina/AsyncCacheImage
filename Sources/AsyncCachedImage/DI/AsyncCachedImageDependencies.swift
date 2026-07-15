//
//  File.swift
//  AsyncCachedImage
//
//  Created by Ульяна Гритчина on 15.07.2026.
//

import Foundation

public final class AsyncCachedImageDependencies {
    let imagePipeline: ImagePipeline
    
    public init(imagePipeline: ImagePipeline) {
        self.imagePipeline = imagePipeline
    }
}

extension AsyncCachedImageDependencies {
    @MainActor public static let live = AsyncCachedImageDependencies(
        imagePipeline: ImagePipelineImpl(
            memoryCache: DefaultMemoryCache(),
            networkLoader: NetworkImageLoaderImpl()
        )
    )
}
