//
//  File.swift
//  
//
//  Created by Thomas Léger on 20/08/2023.
//

import Foundation
import Get

import Cache

public struct Jokes_API: API {
    public struct Models {
        public struct Joke {
            public let id: Int
            public let category: String
            public let type: JokeType
        }

        public enum JokeType {
            case single(joke: String)
            case twoPart(setUp: String, delivery: String)
        }
    }

    public class Controller: APIController {
        public struct Response: Codable {
            let error: Bool
            let category: String
            let type: ResponseJokeType
            let setup: String?
            let delivery: String?
            let joke: String?
            let id: Int
            let safe: Bool
            let lang: String
        }

        public enum ResponseJokeType: String, Codable {
            case single
            case twopart
        }

        private let apiCaller: APICaller
        private let endpointBaseURL: URL = URL(string: "https://v2.jokeapi.dev/joke/Any?blacklistFlags=nsfw,religious,political,racist,sexist,explicit")!

        public init(apiCaller: APICaller) {
            self.apiCaller = apiCaller
        }

        public func callAPI(with cacheConfiguration: CacheConfiguration) async throws -> APIResult<Response> {
            let request = Request(url: endpointBaseURL)
            let result = try await apiCaller.execute(request: request, using: cacheConfiguration)
            let decoder = JSONDecoder()
            let decoded = try decoder.decode(Response.self, from: result.value)
            return .init(value: decoded, cacheResult: result.cacheResult)
        }
    }

    public class Presenter: APIPresenter {
        public func present(_ response: APIResult<Controller.Response>) -> APIResult<Models.Joke> {
            let jokeType: Models.JokeType = {
                switch response.value.type {
                case .single where response.value.joke != nil:
                    return .single(joke: response.value.joke!)
                case .twopart where response.value.setup != nil && response.value.delivery != nil:
                    return .twoPart(setUp: response.value.setup!, delivery: response.value.delivery!)
                default:
                    // FIXME: Implement error handling
                    fatalError("Malformed Response")
                }
            }()
            return .init(
                value: .init(
                    id: response.value.id,
                    category: response.value.category,
                    type: jokeType
                ),
                cacheResult: response.cacheResult
            )
        }
    }

    public static let name = "Jokes"
    public static let websiteURL = URL(string: "https://v2.jokeapi.dev")!

    public let controller: Controller
    public let presenter: Presenter

    private init(controller: Controller, presenter: Presenter) {
        self.controller = controller
        self.presenter = presenter
    }

    public static func instantiate(apiCaller: APICaller = .init()) -> Jokes_API {
        return self.init(controller: Controller(apiCaller: apiCaller), presenter: Presenter())
    }
}
