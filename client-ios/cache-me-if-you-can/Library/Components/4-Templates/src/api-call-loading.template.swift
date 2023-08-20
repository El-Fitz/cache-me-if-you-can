//
//  File.swift
//  
//
//  Created by Thomas Léger on 20/08/2023.
//

import Foundation
import SwiftUI

public extension _Templates {
    struct APICallLoading<Header>: View where Header: View {
        let header: () -> Header

        public init(header: @escaping () -> Header) {
            self.header = header
        }

        public var body: some View {
            // TODO: Fix crazy big headers
            VStack {
                header()
                    .frame(height: 200)
            }
            .padding()
            .navigationTitle("Loading")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

