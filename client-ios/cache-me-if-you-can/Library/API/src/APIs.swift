//
//  File.swift
//  
//
//  Created by Thomas Léger on 19/08/2023.
//

import Foundation
import Get

import Cache

public enum Loadable<T> {
    public struct Exception {
        public let title: String
        public let subtitle: String
        public let underlyingError: Error
    }

    case idle
    case loading(since: Date)
    case loaded(T)
    case failure(Exception)
}

public protocol APIController {
    associatedtype Response
    func callAPI(with cacheConfiguration: CacheConfiguration) async throws -> APIResult<Response>
}

public struct APIResult<T> {
    public let value: T
    public let cacheResult: CacheResult?

    public init(value: T, cacheResult: CacheResult?) {
        self.value = value
        self.cacheResult = cacheResult
    }
}

public protocol APIPresenter {
    associatedtype Response
    associatedtype Result
    func present(_ res: APIResult<Response>) -> APIResult<Result>
}

public protocol API where Controller.Response == Presenter.Response {
    associatedtype Controller: APIController
    associatedtype Presenter: APIPresenter

    static var name: String { get }
    static var websiteURL: URL { get }

    var controller: Controller { get }
    var presenter: Presenter { get }

    static func instantiate(apiCaller: APICaller) -> Self
}

public extension API {
    func callAPI(with cacheConfiguration: CacheConfiguration) -> AsyncStream<Loadable<APIResult<Presenter.Result>>> {
        return AsyncStream { continuation in
            Task {
                do {
                    continuation.yield(.loading(since: .now))
                    async let result = self.presenter.present(try await controller.callAPI(with: cacheConfiguration))
                    try await continuation.yield(.loaded(result))
                } catch {
                    continuation.yield(.failure(.init(title: "Oopsie", subtitle: "An error has occured", underlyingError: error)))
                }
                continuation.finish()
            }
        }
    }
}

public class APICaller {
    public init() { }

    func execute(request: Request<Void>, using cacheConfiguration: CacheConfiguration) async throws -> APIResult<Data> {
        let urlCache = URLCache(
            memoryCapacity: cacheConfiguration.memoryCapacityInMegabytes * 1024 * 1024,
            diskCapacity: cacheConfiguration.diskCapacityInMegabytes * 1024 * 1024,
            directory: try cacheURL(for: cacheConfiguration.directory)
        )
        let sessionConfiguration = URLSessionConfiguration.default
        sessionConfiguration.requestCachePolicy = cacheConfiguration.policy
        sessionConfiguration.urlCache = urlCache

        let client = APIClient(configuration: .init(baseURL: nil, sessionConfiguration: sessionConfiguration))
        let result = try await client.send(request)
        let cachedResponse: CachedURLResponse? = {
            guard let originalRequest = result.originalRequest else { return nil }
            return urlCache.cachedResponse(for: originalRequest)
        }()
        let cacheResult = CacheResult(
            cacheConfiguration: cacheConfiguration,
            currentDiskUsage: urlCache.currentDiskUsage,
            diskCapacity: urlCache.diskCapacity,
            currentMemoryUsage: urlCache.currentMemoryUsage,
            memoryCapacity: urlCache.memoryCapacity,
            urlCache: urlCache,
            cachedResponse: cachedResponse
        )
        return APIResult(value: result.data, cacheResult: cacheResult)
    }

    fileprivate func url(for directory: CacheConfiguration.Directory) -> URL? {
        switch directory {
        case .defaultCacheDirectory:
            return FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first
        case .applicationSupportDirectory:
            return FileManager.default.urls(for: .applicationSupportDirectory, in: .userDomainMask).first
        case .documentsDirectory:
            return FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
        case .tempDirectory:
            return URL(fileURLWithPath: NSTemporaryDirectory(), isDirectory: true)
        }
    }

    fileprivate func cacheURL(for directory: CacheConfiguration.Directory) throws -> URL? {
        guard let url = url(for: directory)?.appending(path: "cache") else {
            return nil
        }
        try FileManager.default.createDirectory(at: url, withIntermediateDirectories: true)
        return url
    }
}
