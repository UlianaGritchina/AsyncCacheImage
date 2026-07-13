//
//  AsyncCachedImage.swift
//  AsyncCachedImage
//
//  Created by Ульяна Гритчина on 13.07.2026.
//

import SwiftUI

public struct AsyncCachedImage: View {
    @State private var viewModel: AsyncCachedImageViewModel
    
    public init(url: URL) {
        viewModel = AsyncCachedImageViewModel(url: url)
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
    AsyncCachedImage(url: URL(string: "")!)
}

extension AsyncCachedImage {
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
