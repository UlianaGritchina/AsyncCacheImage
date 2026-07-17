//
//  DiskCache.swift
//  AsyncCacheImage
//
//  Created by Ульяна Гритчина on 17.07.2026.
//

import Foundation

protocol DiskCache: Sendable {
    func save(data: Data, key: String) async throws
    func getData(key: String) async throws -> Data?
    func delete(key: String) async throws
    func deleteAll() async throws
}
