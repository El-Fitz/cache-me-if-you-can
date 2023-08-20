//
//  File.swift
//  
//
//  Created by Thomas Léger on 20/08/2023.
//

import Foundation
import SwiftUI
import ComponentsCommon

public extension _Molecules {
    struct APICallNavigationLink<Destination>: View where Destination: View {
        let apiName: String
        let website: URL
        let destination: () -> Destination

        public init(
            apiName: String,
            website: URL,
            destination: @escaping () -> Destination
        ) {
            self.apiName = apiName
            self.website = website
            self.destination = destination
        }

        public var body: some View {
            Section(content: {
                NavigationLink(destination: {
                    destination()
                }, label: {
                    Text("Test API")
                })
            }, header: {
                HStack() {
                    Text("\(apiName) API")
                    Spacer()
                    Link(destination: website) {
                        Image(systemName: "link.circle")
                            .font(.system(size: 24))
                            .padding(5)
                    }
                }

            })
            .headerProminence(.increased)
        }
    }
}
