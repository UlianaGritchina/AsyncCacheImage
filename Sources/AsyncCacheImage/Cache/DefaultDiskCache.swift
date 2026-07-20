//
//  DefaultDiskCache.swift
//  AsyncCacheImage
//
//  Created by Ульяна Гритчина on 17.07.2026.
//

import CryptoKit
import Foundation

actor DefaultDiskCache: CacheService {
    private let fileManager = FileManager.default
    private let directory: URL

    init(directoryName: String = "AsyncCacheImage") throws {
        let cachesDirectory = try fileManager
            .url(
                for: .cachesDirectory,
                in: .userDomainMask,
                appropriateFor: nil,
                create: true
            )

        directory = cachesDirectory.appendingPathComponent(directoryName)

        if !fileManager.fileExists(atPath: directory.path) {
            try fileManager.createDirectory(
                at: directory,
                withIntermediateDirectories: true
            )
        }
    }

    func save(data: Data, for key: String) throws {
        try data.write(to: fileURL(for: key), options: .atomic)
    }

    func get(from key: String) throws -> Data {
        let url = fileURL(for: key)

        guard fileManager.fileExists(atPath: url.path) else {
            throw CachingError.noSavedData
        }

        return try Data(contentsOf: url)
    }

    func delete(for key: String) throws {
        let url = fileURL(for: key)

        guard fileManager.fileExists(atPath: url.path) else {
            throw CachingError.noSavedData
        }

        try fileManager.removeItem(at: url)
    }

    func deleteAll() throws {
        let files = try fileManager.contentsOfDirectory(
            at: directory,
            includingPropertiesForKeys: nil
        )

        for file in files {
            try fileManager.removeItem(at: file)
        }
    }
}

private extension DefaultDiskCache {
    func fileURL(for key: String) -> URL {
        directory.appendingPathComponent(hashed(key))
    }

    func hashed(_ key: String) -> String {
        let digest = SHA256.hash(data: Data(key.utf8))
        return digest.map { String(format: "%02x", $0) }.joined()
    }
}
