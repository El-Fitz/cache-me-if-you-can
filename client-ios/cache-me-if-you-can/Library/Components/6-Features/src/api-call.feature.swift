//
//  File.swift
//  
//
//  Created by Thomas Léger on 20/08/2023.
//

import Foundation
import SwiftUI

import API
import Cache

import Templates

public extension _Features {
    struct APICall<Header, APICallResult, ResultView>: View where Header: View, ResultView: View {
        public typealias Result = APIResult<APICallResult>
        @State var cacheConfiguration: CacheConfiguration?
        @State var currentCall: Task<Void, Error>?
        @State var result: Loadable<APIResult<APICallResult>> = .idle

        let apiName: String
        let callAPI: (_ cacheConfig: CacheConfiguration, _ clean: Bool) -> AsyncStream<Loadable<Result>>

        let header: (_ title: String) -> Header
        let resultView: (_ result: Result) -> ResultView

        public init(
            apiName: String,
            callAPI: @escaping (_ cacheConfig: CacheConfiguration, _ clean: Bool) -> AsyncStream<Loadable<Result>>,
            header: @escaping (_ title: String) -> Header,
            resultView: @escaping (_ result: Result) -> ResultView
        ) {
            self.apiName = apiName
            self.callAPI = callAPI
            self.header = header
            self.resultView = resultView
        }

        public var body: some View {
            content()
                .onChange(of: cacheConfiguration) { (_, newCacheConfiguration) in
                    if let newCacheConfiguration {
                        self.currentCall = Task {
                            for await event in callAPI(newCacheConfiguration, true) {
                                try Task.checkCancellation()
                                self.result = event
                            }
                        }
                    }
                    else {
                        self.currentCall?.cancel()
                        self.result = .idle
                    }
                }
        }

        func onCacheConfigUpdate(_ newCacheConfig: CacheConfiguration?) {
            self.cacheConfiguration = newCacheConfig
        }


        @ViewBuilder func content() -> some View {
            switch result {
            case .idle:
                _Templates.APICallSetUp(header: { header(apiName) }, onCacheConfigUpdate: onCacheConfigUpdate)
            case .loading:
                _Templates.APICallLoading(header: { header("Loading") } )
            case .loaded(let result):
                resultView(result)
            case .failure(let exception):
                VStack() {
                    Text(exception.title)
                    Text(exception.subtitle)
                }
                .padding()
            }
        }
    }
}
