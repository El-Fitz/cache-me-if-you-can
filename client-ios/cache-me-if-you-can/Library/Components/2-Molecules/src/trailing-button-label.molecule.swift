//
//  File.swift
//  
//
//  Created by Thomas Léger on 20/08/2023.
//

import Foundation
import SwiftUI

public extension _Molecules {
    struct TrailingButtonLabel<Label, Icon>: View where Label : View, Icon: View {
        let action: () -> Void
        let label: () -> Label
        let icon: () -> Icon

        public init(action: @escaping () -> Void, label: @escaping () -> Label, icon: @escaping () -> Icon) {
            self.action = action
            self.label = label
            self.icon = icon
        }

        public var body: some View {
            HStack() {
                label()
                Spacer()
                Button(action: {
                    action()
                }, label: {
                    icon()
                })
            }
        }
    }
}
