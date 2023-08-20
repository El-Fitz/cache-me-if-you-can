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
    struct ChuckNorris: View {
        @State var headerImage: Image?

        static let API = ChuckNorris_API.self
        let api: ChuckNorris_API

        public var body: some View {
            _Features.APICall(
                apiName: type(of: self).API.name,
                callAPI: { config, clean in api.callAPI(with: config) },
                header: { _Organisms.ChuckNorrisHeader(aspectRatio: .fill, image: loadImage(), title: $0) },
                resultView: { _Pages.ChuckNorrisResult.init($0) }
            )
        }

        func loadImage() -> Image? {
            guard let imageName = ["chuck-norris-0", "chuck-norris-1", "chuck-norris-2"].randomElement() else {
                return nil
            }
            return Image(imageName, bundle: .main)
        }
    }
}
