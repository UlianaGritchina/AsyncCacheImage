//
//  File.swift
//  AsyncCacheImage
//
//  Created by Ульяна Гритчина on 15.07.2026.
//

import Foundation

protocol MemoryCacheService: Sendable {
    func save(data: Data, for key: String) async
    func get(key: String) async -> Data?
    func delete(for key: String) async
    func deleteAll() async
}
