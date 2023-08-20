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
    struct XKCDResult: View {
        @State var image: Image?
        let cacheResult: CacheResult?
        let result: XKCD_API.Models.Comic

        public init(result: APIResult<XKCD_API.Models.Comic>) {
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
            .onAppear() { loadImage() }
            .navigationTitle(result.title)
        }

        @ViewBuilder func content() -> some View {
            if let image {
                // TODO: Try using the image as a luminance mask
                image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding(.vertical)
            } else {
//                        GeometryReader { geometry in
//                            Rectangle()
//                                .fill(.clear)
//                                .frame(width: geometry.size.width - 20, height: geometry.size.width - 20)
//                                .border(.primary, width: /*@START_MENU_TOKEN@*/1/*@END_MENU_TOKEN@*/)
//                                .overlay {
//                                    RoundedRectangle(cornerRadius: 25)
//                                        .frame(width: 120, height: 120)
//                                        .foregroundStyle(.thinMaterial)
//                                        .overlay {
//                                            ProgressView()
//                                                .progressViewStyle(.circular)
//                                        }
//                                }
//                        }
                HStack() {
                    Spacer()
                    RoundedRectangle(cornerRadius: 25)
                        .frame(width: 120, height: 120)
                        .foregroundStyle(.thinMaterial)
                        .padding(40)
                        .overlay {
                            ProgressView()
                                .progressViewStyle(.circular)
                        }
                    Spacer()
                }
            }
            Text(result.alt)
                .font(.caption)
            Spacer()
            Link(destination: result.url, label: {
                HStack() {
                    Text("Page")
                    Spacer()
                    Image(systemName: "link.circle")
                }
                .padding(.horizontal)
            })
            .padding(.vertical)
            .frame(maxWidth: .infinity)
            .background {
                RoundedRectangle(cornerRadius: 12)
                    .fill(.background)
            }
            .padding(.vertical)
        }

        func loadImage() {
            Task {
                let headerImageURL = result.imageURL
                let imageTask = ImagePipeline.shared.imageTask(with: headerImageURL)
                let response = try await imageTask.image
                DispatchQueue.main.async {
                    withAnimation {
                        image = Image(uiImage: response)
                    }
                }
            }
        }
    }
}
