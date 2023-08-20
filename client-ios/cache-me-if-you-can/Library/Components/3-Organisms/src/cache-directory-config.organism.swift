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
    struct CacheDirectoryConfigSection: View {
        @Binding var selectedCacheDirectory: Models.Cache.Directory

        public var body: some View {
            Section(content: {
                NavigationLink(destination: {
                    Form {
                        Section(content: {
                            ForEach(Models.Cache.Directory.allCases) { directory in
                                _Molecules.CacheDirectoryConfigRow(
                                    selectedValue: $selectedCacheDirectory,
                                    value: directory,
                                    title: Models.Cache.title(for: directory)
                                )
                            }
                        })
                        .navigationTitle("Cache Directory")
                    }
                }, label: {
                    Text(Models.Cache.title(for: selectedCacheDirectory))
                })
            }, header: {
                _Organisms.TrailingInfoButton(
                    action: { },
                    title: "Cache Directory",
                    systemImage: "folder"
                )
            })
        }
    }
}
