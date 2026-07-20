//
//  File.swift
//  AsyncCacheImage
//
//  Created by Ульяна Гритчина on 15.07.2026.
//

import Foundation

protocol CacheService: Sendable {
    func save(data: Data, for key: String) async throws
    func get(from key: String) async throws -> Data
    func delete(for key: String) async throws
    func deleteAll() async throws
}
