//
//  File.swift
//  
//
//  Created by Thomas Léger on 20/08/2023.
//

import Foundation
import SwiftUI
import ComponentsCommon

public extension _Molecules {
    struct CacheDirectoryDetailsNavigationLink<Destination>: View where Destination: View {
        let cacheDirectory: Models.Cache.Directory
        let destination: (_ directory: Models.Cache.Directory) -> Destination

        public init(
            cacheDirectory: Models.Cache.Directory,
            destination: @escaping (_ directory: Models.Cache.Directory) -> Destination
        ) {
            self.cacheDirectory = cacheDirectory
            self.destination = destination
        }

        public var body: some View {
            NavigationLink(destination: {
                destination(cacheDirectory)
            }, label: {
                Text(Models.Cache.title(for: cacheDirectory))
            })
        }
    }
}
