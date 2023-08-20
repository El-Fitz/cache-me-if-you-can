//
//  File.swift
//  
//
//  Created by Thomas Léger on 19/08/2023.
//

import Foundation
import SwiftUI

public extension _Molecules {
    struct DestructiveButton<Label>: View where Label : View {
        let action: () -> Void
        let label: () -> Label

        public init(action: @escaping () -> Void, label: @escaping () -> Label) {
            self.action = action
            self.label = label
        }

        public var body: some View {
            Button(action: action, label: {
                label().foregroundStyle(.red)
            })
        }
    }
}
