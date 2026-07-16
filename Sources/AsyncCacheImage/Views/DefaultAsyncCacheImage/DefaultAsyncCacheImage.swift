//
//  DefaultAsyncCacheImage.swift
//  AsyncCacheImage
//
//  Created by Ульяна Гритчина on 16.07.2026.
//

import SwiftUI

public struct DefaultAsyncCacheImage: View {
    let url: URL
    
    public init(url: URL) {
        self.url = url
    }
    
    public var body: some View {
        AsyncCacheImage(url: url) { image in
            image
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .cornerRadius(10)
        } placeholder: {
            DefaultPlaceholder()
        }
    }
}

#Preview {
    DefaultAsyncCacheImage(
        url: URL(string: "https://yavuzceliker.github.io/sample-images/image-1021.jpg")!
    )
    .padding()
}
