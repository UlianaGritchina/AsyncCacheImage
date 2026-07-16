//
//  SwiftUIView.swift
//  AsyncCacheImage
//
//  Created by Ульяна Гритчина on 13.07.2026.
//

import Foundation

@MainActor
@Observable
final class AsyncCacheImageViewModel {
    
    private let pipeline: ImagePipeline
    private let url: URL
    
    var loadingState: LoadingState = .loading
    
    init(url: URL, pipeline: ImagePipeline) {
        self.url = url
        self.pipeline = pipeline
        loadImageData()
    }
    
    private func loadImageData() {
        guard case .loading = loadingState else { return }
        
        Task {
            do {
                let imageData = try await pipeline.getImageData(for: url)
                loadingState = .loaded(imageData: imageData)
            } catch {
                loadingState = .error
            }
        }
    }
}
