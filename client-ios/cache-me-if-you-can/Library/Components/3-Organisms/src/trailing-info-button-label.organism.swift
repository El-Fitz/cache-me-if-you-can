//
//  File.swift
//  
//
//  Created by Thomas Léger on 20/08/2023.
//

import Foundation
import SwiftUI

import Molecules

public extension _Organisms {
    struct TrailingInfoButton: View {
        let action: () -> Void
        let title: String
        let systemImage: String

        public init(action: @escaping () -> Void, title: String, systemImage: String) {
            self.action = action
            self.title = title
            self.systemImage = systemImage
        }

        public var body: some View {
            _Molecules.TrailingButtonLabel(action: {
                action()
            }, label: {
                Label(title, systemImage: systemImage)
            }, icon: {
                EmptyView()
                // TODO: Restore button, implement action
//                Image(systemName: "info.circle")
            })
        }
    }
}
