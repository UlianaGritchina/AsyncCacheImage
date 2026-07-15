//
//  ImagePipeline.swift
//  AsyncCachedImage
//
//  Created by Ульяна Гритчина on 13.07.2026.
//

import Foundation

public protocol ImagePipeline: Sendable {
    func getImageData(for url: URL) async throws -> Data
}
