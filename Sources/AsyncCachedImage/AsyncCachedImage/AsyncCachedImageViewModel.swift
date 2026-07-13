//
//  SwiftUIView.swift
//  AsyncCachedImage
//
//  Created by Ульяна Гритчина on 13.07.2026.
//

import Foundation

@Observable
final class AsyncCachedImageViewModel {
    
    private let imagePipeline: ImagePipeline
    private let url: URL
    
    var loadingState: LoadingState = .loading
    
    init(url: URL) {
        self.url = url
        imagePipeline = ImagePipelineImpl(
            memoryCache: MemoryCacheServiceImpl(),
            networkImageLoader: NetworkImageLoaderImpl()
        )
    }
    
    @MainActor
    func loadImageData() async {
        do {
            let imageData = try await imagePipeline.getImageData(for: url)
            loadingState = .loaded(imageData: imageData)
        } catch {
            loadingState = .error
        }
    }
}
