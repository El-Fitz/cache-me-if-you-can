//
//  File.swift
//  
//
//  Created by Thomas Léger on 20/08/2023.
//

import Foundation
import Get

import Cache

public struct ChuckNorris_API: API {
    public struct Models {
        public struct Joke {
            public let id: String
            public let categories: [String]
            public let url: URL
            public let value: String
        }
    }

//    public struct Result {
//
//    }

    public class Controller: APIController {
        public struct Response: Codable {
            let id: String
            let created_at: Date
            let updated_at: Date

            let categories: [String]
            let url: URL
            let value: String
        }

        private let apiCaller: APICaller
        private let dateFormatter: DateFormatter
        private let endpointBaseURL: URL = URL(string: "https://api.chucknorris.io/jokes/random?category=animal,career,celebrity,dev,fashion,food,history,money,movie,music,political,religion,science,sport,travel")!

        public init(apiCaller: APICaller) {
            self.apiCaller = apiCaller
            self.dateFormatter = DateFormatter()
            self.dateFormatter.dateFormat = "YYYY-MM-DD HH:mm:ss.SSS"
        }

        public func callAPI(with cacheConfiguration: CacheConfiguration) async throws -> APIResult<Response> {
            let request = Request(url: endpointBaseURL)
            let result = try await apiCaller.execute(request: request, using: cacheConfiguration)
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .formatted(dateFormatter)
            let decoded = try decoder.decode(Response.self, from: result.value)
            return .init(value: decoded, cacheResult: result.cacheResult)
        }
    }

    public class Presenter: APIPresenter {
        public func present(_ response: APIResult<Controller.Response>) -> APIResult<Models.Joke> {
            return .init(
                value: .init(
                    id: response.value.id,
                    categories: response.value.categories,
                    url: response.value.url,
                    value: response.value.value
                ),
                cacheResult: response.cacheResult
            )
        }
    }

    public static let name = "Chuck Norris"
    public static let websiteURL = URL(string: "https://api.chucknorris.io")!

    public let controller: Controller
    public let presenter: Presenter

    private init(controller: Controller, presenter: Presenter) {
        self.controller = controller
        self.presenter = presenter
    }

    public static func instantiate(apiCaller: APICaller = .init()) -> ChuckNorris_API {
        return self.init(controller: Controller(apiCaller: apiCaller), presenter: Presenter())
    }
}
