// The Swift Programming Language
// https://docs.swift.org/swift-book

import Foundation

public struct CacheResult {
    public let cacheConfiguration: CacheConfiguration
    public let currentDiskUsage: Int
    public let diskCapacity: Int
    public let currentMemoryUsage: Int
    public let memoryCapacity: Int
    public let urlCache: URLCache
    public let cachedResponse: CachedURLResponse?

    public init(
        cacheConfiguration: CacheConfiguration,
        currentDiskUsage: Int,
        diskCapacity: Int,
        currentMemoryUsage: Int,
        memoryCapacity: Int,
        urlCache: URLCache,
        cachedResponse: CachedURLResponse?
    ) {
        self.cacheConfiguration = cacheConfiguration
        self.currentDiskUsage = currentDiskUsage
        self.diskCapacity = diskCapacity
        self.currentMemoryUsage = currentMemoryUsage
        self.memoryCapacity = memoryCapacity
        self.urlCache = urlCache
        self.cachedResponse = cachedResponse
    }
}

public struct CacheConfiguration: Equatable {
    public enum Directory: Equatable {
        case defaultCacheDirectory
        case applicationSupportDirectory
        case documentsDirectory
        case tempDirectory
    }

    public let directory: Directory
    public let diskCapacityInMegabytes: Int
    public let memoryCapacityInMegabytes: Int
    public let policy: NSURLRequest.CachePolicy

    public init(
        policy: NSURLRequest.CachePolicy,
        directory: Directory,
        diskCapacityInMegabytes: Int,
        memoryCapacityInMegabytes: Int
    ) {
        self.policy = policy
        self.directory = directory
        self.diskCapacityInMegabytes = diskCapacityInMegabytes
        self.memoryCapacityInMegabytes = memoryCapacityInMegabytes
    }
}
