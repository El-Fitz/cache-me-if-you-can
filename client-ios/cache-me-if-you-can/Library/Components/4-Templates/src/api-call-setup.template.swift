//
//  File.swift
//  
//
//  Created by Thomas Léger on 19/08/2023.
//

import Foundation
import SwiftUI

import Cache
import ComponentsCommon
import Organisms

public extension _Templates {
    struct APICallSetUp<Header>: View where Header: View {
        let header: () -> Header
        let onCacheConfigUpdate: (_ config: CacheConfiguration?) -> Void

        public init(
            header: @escaping () -> Header,
            onCacheConfigUpdate: @escaping (_ config: CacheConfiguration?) -> Void
        ) {
            self.header = header
            self.onCacheConfigUpdate = onCacheConfigUpdate
        }

        public var body: some View {
            List {
                header()
                    .listRowSeparator(.hidden)
                    .listRowBackground(Color(UIColor.systemGroupedBackground))
                    .padding(0)
                _Organisms.CacheConfigSetUpView(onCompletion: { (directory, policy, disk, memory) in
                    onCacheConfigUpdate(.init(
                        policy: Models.Cache.policyFor(policy),
                        directory: Models.Cache.directoryFor(directory),
                        diskCapacityInMegabytes: disk,
                        memoryCapacityInMegabytes: memory
                    ))
                })
                .listRowSeparator(.hidden)
            }
            .scrollIndicators(.hidden)
//            .listStyle(.plain)
            .buttonStyle(.borderless)
            .multilineTextAlignment(.leading)
            .navigationTitle("Cache Configuration")
        }
    }
}

