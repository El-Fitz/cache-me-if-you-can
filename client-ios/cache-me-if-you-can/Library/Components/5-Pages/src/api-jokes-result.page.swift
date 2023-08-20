//
//  File.swift
//  
//
//  Created by Thomas Léger on 20/08/2023.
//

import SwiftUI

import Nuke

import API
import Cache
import Organisms
import Templates

public extension _Pages {
    struct JokesResult: View {
        @State var image: Image?
        let cacheResult: CacheResult?
        let result: Jokes_API.Models.Joke

        public init(result: APIResult<Jokes_API.Models.Joke>) {
            self.cacheResult = result.cacheResult
            self.result = result.value
        }

        public var body: some View {
            _Templates.ResultView(
                cacheResult: cacheResult,
                content: content,
                retryRequest: {

                },
                newRequest: {
                    
                }
            )
            .navigationTitle(result.category)
        }

        @ViewBuilder func content() -> some View {
            switch result.type {
            case .single(let joke):
                Text(joke)
            case .twoPart(let setUp, let delivery):
                Text("Q: \(setUp)")
                Spacer()
                    .frame(height: 20)
                Text("A: \(delivery)")
                    .redacted(reason: .privacy)
            }
        }
    }
}
