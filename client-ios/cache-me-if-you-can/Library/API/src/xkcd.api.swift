//
//  File.swift
//  
//
//  Created by Thomas Léger on 19/08/2023.
//

import Foundation
import Get

import Cache

public struct XKCD_API: API {
    public struct Models {
        public struct Comic {
            public let alt: String
            public let imageURL: URL
            public let number: Int
            public let title: String
            public let url: URL
        }
    }

    public class Controller: APIController {
        public class UrlTaskDelegate: NSObject, URLSessionTaskDelegate {
            public override init() {
                super.init()
            }


        }
        public struct Response: Codable {
            let num: Int
            let day: String
            let month: String
            let year: String

            let alt: String
            let img: URL

            let safe_title: String
            let title: String

            let news: String
            let transcript: String
        }

        private let apiCaller: APICaller
        private let comicNumber: Int
        private let endpointBaseURL: URL = URL(string: "https://xkcd.com")!

        public init(apiCaller: APICaller, comicNumber: Int? = nil) {
            self.apiCaller = apiCaller
            self.comicNumber = comicNumber ?? Int.random(in: 0...2817)
        }


        public func callAPI(with cacheConfiguration: CacheConfiguration) async throws -> APIResult<Response> {

            let request = Request(url: endpointBaseURL.appending(path: "\(comicNumber)/info.0.json"))
            let result = try await apiCaller.execute(request: request, using: cacheConfiguration)
            let decoder = JSONDecoder()
            let decoded = try decoder.decode(Response.self, from: result.value)
            return .init(value: decoded, cacheResult: result.cacheResult)
        }
    }

    public class Presenter: APIPresenter {
        public func present(_ response: APIResult<Controller.Response>) -> APIResult<Models.Comic> {
            return APIResult(
                value: .init(
                    alt: response.value.alt,
                    imageURL: response.value.img,
                    number: response.value.num,
                    title: response.value.title,
                    url: URL(string: "https://xkcd.com/\(response.value.num)/")!
                ),
                cacheResult: response.cacheResult
            )
        }
    }

    public static let name = "XKCD"
    public static let websiteURL = URL(string: "https://xckd.com")!

    public let controller: Controller
    public let presenter: Presenter

    private init(controller: Controller, presenter: Presenter) {
        self.controller = controller
        self.presenter = presenter
    }

    public static func instantiate(apiCaller: APICaller = .init()) -> XKCD_API {
        return self.init(controller: Controller(apiCaller: apiCaller), presenter: Presenter())
    }
}
