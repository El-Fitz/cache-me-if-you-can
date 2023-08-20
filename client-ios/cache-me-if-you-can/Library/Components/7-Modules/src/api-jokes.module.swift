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
import Pages
import Features

public extension _Modules {
    struct Jokes: View {

        static let API = Jokes_API.self
        let api: Jokes_API

        public var body: some View {
            _Features.APICall(
                apiName: type(of: self).API.name,
                callAPI: { config, clean in api.callAPI(with: config) },
                header: { _ in EmptyView() },
                resultView: _Pages.JokesResult.init(result:)
            )
        }
    }
}
