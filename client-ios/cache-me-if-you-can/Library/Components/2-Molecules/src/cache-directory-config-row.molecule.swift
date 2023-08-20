//
//  File.swift
//  
//
//  Created by Thomas Léger on 20/08/2023.
//
import SwiftUI

public extension _Molecules {
    struct CacheDirectoryConfigRow<Value>: View where Value: Equatable {

        @Binding var selectedValue: Value
        let value: Value
        let title: String

        public init(selectedValue: Binding<Value>, value: Value, title: String) {
            self._selectedValue = selectedValue
            self.value = value
            self.title = title
        }

        public var body: some View {
            HStack {
                Button(action: {
                    selectedValue = value
                }, label: {
                    Label(title, systemImage: selectedValue == value ? "circle.circle.fill" : "circle.dotted")
                        .multilineTextAlignment(.leading)
                        .fontWeight(selectedValue == value ? .medium : .regular)
                })
                Spacer()
                Button(action: {

                }, label: {
                    Image(systemName: "info.circle")
                })
            }
            .foregroundStyle(selectedValue == value ? .green : .accentColor)
        }
    }
}
