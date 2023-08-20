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
    struct CacheMemoryCapacityConfigSection: View {
        @Binding var selectedCacheMemoryCapacity: Float

        public var body: some View {
            Section(content: {
                HStack() {
                    Text("Cache Memory Capacity:")
                    Spacer()
                    Text("\(Int(selectedCacheMemoryCapacity))MB")
                }
                Slider(value: $selectedCacheMemoryCapacity, in: 0...100, step: 10)
            }, header: {
                _Organisms.TrailingInfoButton(
                    action: { },
                    title: "Memory",
                    systemImage: "memorychip"
                )
            })
        }
    }
}
