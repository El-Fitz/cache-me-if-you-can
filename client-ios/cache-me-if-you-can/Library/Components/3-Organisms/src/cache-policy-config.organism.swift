//
//  File.swift
//  
//
//  Created by Thomas Léger on 20/08/2023.
//

import SwiftUI
import Cache
import ComponentsCommon
import Molecules

public extension _Organisms {
    struct CachePolicyConfigSection: View {
        @Binding var selectedCachePolicy: Models.Cache.Policy

        public var body: some View {
            Section(content: {
                NavigationLink(destination: {
                    Form {
                        Section(content: {
                            ForEach(Models.Cache.Policy.allCases) { policy in
                                _Molecules.CacheDirectoryConfigRow(
                                    selectedValue: $selectedCachePolicy,
                                    value: policy,
                                    title: Models.Cache.title(for: policy)
                                )
                            }
                        })
                        .navigationTitle("Cache Policy")
                    }
                }, label: {
                    Text(Models.Cache.title(for: selectedCachePolicy))
                })
            }, header: {
                _Organisms.TrailingInfoButton(
                    action: { },
                    title: "Cache Policy",
                    systemImage: "doc.badge.gearshape"
                )
            })
        }
    }
}
