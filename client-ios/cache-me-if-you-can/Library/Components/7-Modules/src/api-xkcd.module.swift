//
//  File.swift
//  
//
//  Created by Thomas Léger on 20/08/2023.
//

import Foundation
import SwiftUI

import Nuke

import API
import Cache
import Organisms
import Pages
import Features

public extension _Modules {
    struct XKCD: View {
        @State var headerImage: Image?

        static let API = XKCD_API.self
        @State var api: XKCD_API

        public var body: some View {
            _Features.APICall(
                apiName: type(of: self).API.name,
                callAPI: { config, clean in
                    // TODO: Clear Cache
                    if clean { self.api = .instantiate() }
                    return api.callAPI(with: config)
                },
                header: { _Organisms.XKCDHeader(image: $headerImage, title: $0) },
                resultView: _Pages.XKCDResult.init(result:)
            )
            .onAppear() { loadImage() }
        }

        func loadImage() {
            Task {
                let headerImageURL = URL(string: "https://imgs.xkcd.com/comics/angular_momentum.jpg")!
                let imageTask = ImagePipeline.shared.imageTask(with: headerImageURL)
                let reponseImage = try await imageTask.image
                DispatchQueue.main.async {
                    withAnimation {
                        headerImage = Image(uiImage: reponseImage)
                    }
                }
            }
        }
    }
}
