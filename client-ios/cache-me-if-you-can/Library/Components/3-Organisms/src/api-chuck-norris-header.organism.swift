//
//  File.swift
//  
//
//  Created by Thomas Léger on 20/08/2023.
//

import Foundation
import SwiftUI

import Nuke
import Nuke

public extension _Organisms {
    struct ChuckNorrisHeader: View {

        let aspectRatio: ContentMode
        let image: Image?
        let title: String

        public init(
            aspectRatio: ContentMode,
            image: Image?,
            title: String
        ) {
            self.aspectRatio = aspectRatio
            self.image = image
            self.title = title
        }

        public var body: some View {
            image?
                .resizable()
                .scaledToFill()
                .aspectRatio(contentMode: aspectRatio)
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
                                            Text(title)
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
        }
    }
}
