//
//  LoadingState.swift
//  AsyncCacheImage
//
//  Created by Ульяна Гритчина on 13.07.2026.
//

import Foundation

enum LoadingState {
    case loading
    case loaded(imageData: Data)
    case error
}
