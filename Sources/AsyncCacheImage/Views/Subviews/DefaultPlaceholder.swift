//
//  DefaultPlaceholder.swift
//  AsyncCacheImage
//
//  Created by Ульяна Гритчина on 16.07.2026.
//

import SwiftUI

public struct DefaultPlaceholder: View {
    public init() { }
    
    public var body: some View {
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


#Preview {
    DefaultPlaceholder()
}

