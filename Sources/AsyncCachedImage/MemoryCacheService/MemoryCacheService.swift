//
//  MemoryCacheService.swift
//  AsyncCachedImage
//
//  Created by Ульяна Гритчина on 13.07.2026.
//

import Foundation

protocol MemoryCacheService: Sendable {
    func save(data: Data, for key: String)
    func get(key: String) -> Data?
    func delete(for key: String)
    func deleteAll()
}

final class MemoryCacheServiceImpl: MemoryCacheService, @unchecked Sendable {
    private let cache = NSCache<NSString, NSData>()
    
    init(
        countLimit: Int = 100,
        costLimit: Int = 100 * 1024 * 1024
    ) {
        cache.countLimit = countLimit
        cache.totalCostLimit = costLimit
    }
    
    func save(data: Data, for key: String) {
        cache.setObject(data as NSData, forKey: key as NSString, cost: data.count)
    }
    
    func get(key: String) -> Data? {
        cache.object(forKey: key as NSString) as Data?
    }
    
    func delete(for key: String) {
        cache.removeObject(forKey: key as NSString)
    }
    
    func deleteAll() {
        cache.removeAllObjects()
    }
}
