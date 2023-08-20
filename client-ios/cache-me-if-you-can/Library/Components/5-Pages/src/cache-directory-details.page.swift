//
//  File.swift
//  
//
//  Created by Thomas Léger on 20/08/2023.
//

import Foundation
import OSLog
import SwiftUI

import Cache

import ComponentsCommon
import Molecules

extension _Pages {
    public struct CacheDirectoryDetails: View {
        let cacheDirectory: Models.Cache.Directory

        public init(cacheDirectory: Models.Cache.Directory) {
            self.cacheDirectory = cacheDirectory
        }

        public var body: some View {
            List {
                _Molecules.DestructiveButton(action: {
                    Logger().log("Clear \(Models.Cache.title(for: cacheDirectory))")
                }, label: {
                    Text("Clear \(Models.Cache.title(for: cacheDirectory))")
                })
            }
            .navigationTitle(Models.Cache.title(for: cacheDirectory))
        }
    }
}
