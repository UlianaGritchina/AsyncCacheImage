//
//  ImageLoaderError.swift
//  AsyncCacheImage
//
//  Created by Ульяна Гритчина on 13.07.2026.
//

import Foundation

enum ImageLoaderError: Error {
    case invalidResponse
    case httpError(statusCode: Int)
    case emptyData
}
