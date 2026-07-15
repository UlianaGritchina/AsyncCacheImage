//
//  AsyncCacheImage.swift
//  AsyncCacheImage
//
//  Created by Ульяна Гритчина on 13.07.2026.
//

import SwiftUI

public struct AsyncCacheImage: View {
    @State private var viewModel: AsyncCacheImageViewModel
    
    public init(url: URL, dependencies: AsyncCacheImageDependencies = .live) {
        viewModel = AsyncCacheImageViewModel(
            url: url,
            pipeline: dependencies.imagePipeline
        )
    }
    
    public var body: some View {
        VStack {
            switch viewModel.loadingState {
            case .loading:
                placeholder
            case .loaded(let imageData):
                Image(uiImage: UIImage(data: imageData)!)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .cornerRadius(10)
                    .transition(.opacity)
            case .error:
                placeholder
            }
        }
        .task {
            await viewModel.loadImageData()
        }
    }
}

#Preview {
    AsyncCacheImage(url: URL(string: "https://apod.nasa.gov/apod/image/2607/red_sprite.jpg")!)
}

extension AsyncCacheImage {
    private var placeholder: some View {
        Rectangle()
            .foregroundStyle(Color.gray.opacity(0.3))
            .opacity(0.5)
            .frame(height: 250)
            .cornerRadius(8)
            .overlay {
                ProgressView()
            }
    }
}
