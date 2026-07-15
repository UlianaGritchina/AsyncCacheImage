//
//  SwiftUIView.swift
//  AsyncCacheImage
//
//  Created by Ульяна Гритчина on 13.07.2026.
//

import Foundation

@Observable
final class AsyncCacheImageViewModel {
    
    private let pipeline: ImagePipeline
    private let url: URL
    
    var loadingState: LoadingState = .loading
    
    init(url: URL, pipeline: ImagePipeline) {
        self.url = url
        self.pipeline = pipeline
    }
    
    @MainActor
    func loadImageData() async {
        guard case .loading = loadingState else { return }
        
        do {
            let imageData = try await pipeline.getImageData(for: url)
            loadingState = .loaded(imageData: imageData)
        } catch {
            loadingState = .error
        }
    }
}
