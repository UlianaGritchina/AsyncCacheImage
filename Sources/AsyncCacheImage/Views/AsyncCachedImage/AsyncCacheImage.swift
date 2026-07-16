//
//  AsyncCacheImage.swift
//  AsyncCacheImage
//
//  Created by Ульяна Гритчина on 13.07.2026.
//

import SwiftUI

public struct AsyncCacheImage<Content: View, Placeholder: View>: View {
    @State private var viewModel: AsyncCacheImageViewModel
    
    private let content: (Image) -> Content
    private let placeholder: () -> Placeholder
    
    /// Initializes an `AsyncCacheImage` that asynchronously loads and caches an image from the specified URL.
    /// ### Parameters
    /// - `url`: The URL of the image to load.
    /// - `content`: A view builder that receives the loaded `Image` and returns the view used to display it.
    /// - `placeholder`: A view builder that provides a placeholder while the image is loading or if loading fails. Defaults to `DefaultPlaceholder()`.
    /// ### Example
    ///  ```swift
    ///AsyncCacheImage(url: imageURL) { image in
    ///     image
    ///         .resizable()
    ///         .scaledToFit()
    /// } placeholder: {
    ///     ProgressView()
    /// }
    /// ```
    public init(
        url: URL,
        @ViewBuilder
        content: @escaping (Image) -> Content,
        @ViewBuilder
        placeholder: @escaping () -> Placeholder = { DefaultPlaceholder() },
    ) {
        let vm = AsyncCacheImageViewModel(
            url: url,
            pipeline: AsyncCacheImageDependencies.live.imagePipeline
        )
        _viewModel = State(wrappedValue: vm)
        
        self.content = content
        self.placeholder = placeholder
    }
    
    public var body: some View {
        Group {
            switch viewModel.loadingState {
            case .loading:
                placeholder()
                
            case .loaded(let data):
                if let uiImage = UIImage(data: data) {
                    content(Image(uiImage: uiImage))
                } else {
                    placeholder()
                }
                
            case .error:
                placeholder()
            }
        }
        .task {
            await viewModel.loadImageData()
        }
    }
}

#Preview {
    AsyncCacheImage(
        url: URL(string: "https://yavuzceliker.github.io/sample-images/image-1021.jpg")!) { image in
            image
                .resizable()
                .frame(width: 100, height: 100)
        }
}
