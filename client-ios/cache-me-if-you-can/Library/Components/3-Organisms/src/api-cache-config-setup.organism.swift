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
    struct CacheConfigSetUpView: View {

        public typealias Completion = (
            _ cacheDirectory:   Models.Cache.Directory,
            _ cachePolicy:      Models.Cache.Policy,
            _ diskCapacity:     Int,
            _ memoryCapacity:   Int
        ) -> Void

        @State var selectedCacheDirectory:              Models.Cache.Directory
        @State var selectedCachePolicy:                 Models.Cache.Policy
        @State var selectedDiskCapacityInMegabytes:     Float
        @State var selectedMemoryCapacityInMegabytes:   Float

        let onCompletion: Completion

        public init(
            selectedCacheDirectory: Models.Cache.Directory  = .defaultCacheDirectory,
            selectedCachePolicy: Models.Cache.Policy        = .useProtocolCachePolicy,
            selectedDiskCapacityInMegabytes: Float          = 50,
            selectedMemoryCapacityInMegabytes: Float        = 10,
            onCompletion: @escaping Completion
        ) {
            self.selectedCacheDirectory = selectedCacheDirectory
            self.selectedCachePolicy = selectedCachePolicy
            self.selectedDiskCapacityInMegabytes = selectedDiskCapacityInMegabytes
            self.selectedMemoryCapacityInMegabytes = selectedMemoryCapacityInMegabytes
            self.onCompletion = onCompletion
        }

        public var body: some View {
            _Organisms.CacheDirectoryConfigSection(selectedCacheDirectory: $selectedCacheDirectory)
            _Organisms.CachePolicyConfigSection(selectedCachePolicy: $selectedCachePolicy)
            _Organisms.CacheDiskCapacityConfigSection(selectedCacheDiskCapacity: $selectedDiskCapacityInMegabytes)
            _Organisms.CacheMemoryCapacityConfigSection(selectedCacheMemoryCapacity: $selectedMemoryCapacityInMegabytes)
            Section(content: {
                Button(action: {
                    onCompletion(
                        selectedCacheDirectory,
                        selectedCachePolicy,
                        Int(selectedDiskCapacityInMegabytes),
                        Int(selectedMemoryCapacityInMegabytes)
                    )
                }, label: {
                    Text("Call API")
                        .font(.largeTitle)
                        .frame(maxWidth: .infinity)
                })
                .frame(height: 60)
                .foregroundStyle(.white)
                .padding(0)
                .background(.tint)
                .clipShape(RoundedRectangle(cornerRadius: 12))
            })
            .listRowBackground(Color(UIColor.systemGroupedBackground))
        }
    }
}
