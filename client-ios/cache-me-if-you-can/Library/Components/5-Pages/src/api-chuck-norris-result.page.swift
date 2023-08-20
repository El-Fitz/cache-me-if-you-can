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
import Templates

public extension _Pages {
    struct ChuckNorrisResult: View {
        @State var headerImage: Image?
        let cacheResult: CacheResult?
        let result: ChuckNorris_API.Models.Joke

        public init(
            _ result: APIResult<ChuckNorris_API.Models.Joke>
        ) {
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
            .navigationBarTitleDisplayMode(.inline)
            .onAppear() {
                loadImage()
            }
        }

        @ViewBuilder func content() -> some View {
                headerImage?
                    .resizable()
                    .scaledToFill()
                    .frame(height: 200, alignment: .top)
                    .overlay {
                        Group {
                            Rectangle()
                                .foregroundStyle(.ultraThinMaterial)
                            Rectangle()
                                .foregroundStyle(.primary)
                                .mask {
                                    Rectangle()
                                        .foregroundStyle(.white)
                                        .overlay {
                                            VStack(alignment: .leading) {
                                                Spacer()
                                                Text("Chuck Norris")
                                                    .foregroundStyle(.black)
                                                    .font(.title)
                                                    .fontWeight(.heavy)
                                            }
                                        }
                                        .drawingGroup()
                                        .luminanceToAlpha()
                                }
                        }
                        .mask {
                            Rectangle()
                                .foregroundStyle(.white)
                                .overlay {
                                    RoundedRectangle(cornerRadius: 23)
                                        .padding(.top, 5)
                                        .padding(.horizontal, 5)
                                        .padding(.bottom, 35)
                                        .foregroundStyle(.black)
                                }
                                .drawingGroup()
                                .luminanceToAlpha()
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .padding(.vertical)
                Text(result.value)
        }

        func loadImage() {
            guard let imageName = ["chuck-norris-0", "chuck-norris-1", "chuck-norris-2"].randomElement() else {
                return
            }
            self.headerImage = Image(imageName, bundle: .main)
        }
    }
}


