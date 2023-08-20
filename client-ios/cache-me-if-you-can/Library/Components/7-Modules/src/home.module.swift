//
//  File.swift
//  
//
//  Created by Thomas Léger on 20/08/2023.
//

import Foundation
import OSLog
import SwiftUI

import ComponentsCommon
import Molecules
import Pages

struct APIsList: View {

    public init() { }

    public var body: some View {
        _Molecules.APICallNavigationLink(
            apiName: _Modules.ChuckNorris.API.name,
            website: _Modules.ChuckNorris.API.websiteURL,
            destination: { _Modules.ChuckNorris(api: .instantiate()) }
        )
//        _Molecules.APICallNavigationLink(
//            apiName: _Modules.Dogs.API.name,
//            destination: { _Modules.Dogs(api: .instantiate()) }
//        )
        _Molecules.APICallNavigationLink(
            apiName: _Modules.Jokes.API.name,
            website: _Modules.Jokes.API.websiteURL,
            destination: { _Modules.Jokes(api: .instantiate()) }
        )
        _Molecules.APICallNavigationLink(
            apiName: _Modules.XKCD.API.name,
            website: _Modules.XKCD.API.websiteURL,
            destination: { _Modules.XKCD(api: .instantiate()) }
        )
    }
}

public extension _Modules {
    struct Home: View {

        public init() { }

        public var body: some View {
            NavigationStack(root: {
                Form(content: {
                    Spacer()
                        .listRowBackground(Color(UIColor.systemGroupedBackground))
                    APIsList()
                    Section(content: {
                        ForEach(Models.Cache.Directory.allCases, content: { directory in
                            _Molecules.CacheDirectoryDetailsNavigationLink(
                                cacheDirectory: directory,
                                destination: {
                                    _Pages.CacheDirectoryDetails(cacheDirectory: $0)
                                })
                        })
                    }, header: {
                        Label("Cache Directories", systemImage: "folder")
                    })
                })
                .buttonStyle(.borderless)
                .navigationTitle("Home")
            })
        }
    }
}
