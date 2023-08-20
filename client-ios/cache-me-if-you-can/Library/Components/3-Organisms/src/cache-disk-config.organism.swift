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
    struct CacheDiskCapacityConfigSection: View {
        @Binding var selectedCacheDiskCapacity: Float

        public var body: some View {
            Section(content: {
                HStack() {
                    Text("Cache Disk Capacity:")
                    Spacer()
                    Text("\(Int(selectedCacheDiskCapacity))MB")
                }
                Slider(value: $selectedCacheDiskCapacity, in: 0...500, step: 50)
            }, header: {
                _Organisms.TrailingInfoButton(
                    action: { },
                    title: "Disk",
                    systemImage: "internaldrive"
                )
            })
        }
    }
}
