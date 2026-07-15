//
//  NetworkLoader.swift
//  AsyncCachedImage
//
//  Created by Ульяна Гритчина on 15.07.2026.
//

import Foundation

protocol NetworkLoader: Sendable {
    func data(from url: URL) async throws -> Data
}
