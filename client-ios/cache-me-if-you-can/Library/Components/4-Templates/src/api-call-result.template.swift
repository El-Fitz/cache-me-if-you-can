//
//  File.swift
//  
//
//  Created by Thomas Léger on 20/08/2023.
//

import Foundation
import SwiftUI

import Nuke

import API
import Cache
import ComponentsCommon
import Organisms

public struct CacheResultsView: View {
    let cacheResult: CacheResult?

//    var prettyPrintedCachedResponse: String? {
//        guard let cachedResponse = cacheResult?.cachedResponse else {
//            return nil
//        }
//        guard let data cachedResponse.response.
//
//        guard let object = try? JSONSerialization.jsonObject(with: cacheResult?.cachedResponse, options: []),
//              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
//              let prettyPrintedString = String(data: data, encoding:.utf8) else { return nil }
//    }

    public var body: some View {
        Form() {
            Section(content: {
                if let directory = cacheResult?.cacheConfiguration.directory {
                    Text(Models.Cache.title(for: Models.Cache.directoryFor(directory)))
                } else {
                    Spacer()
                }
            }, header: {
                Label("Directory", systemImage: "folder")
            })
            Section(content: {
                if let policy = cacheResult?.cacheConfiguration.policy {
                    Text(Models.Cache.title(for: Models.Cache.policyFor(policy)))
                }
            }, header: {
                Label("Policy", systemImage: "doc.badge.gearshape")
            })
            Section(content: {
                HStack() {
                    Text("Configured Capacity")
                    Spacer()
                    if let capacity = cacheResult?.cacheConfiguration.diskCapacityInMegabytes {
                        Text("\(capacity) MB")
                    }
                }
                HStack() {
                    Text("Capacity")
                    Spacer()
                    if let capacity = cacheResult?.diskCapacity {
                        Text("\(capacity) bytes")
                    }
                }
                HStack() {
                    Text("Usage")
                    Spacer()
                    if let usage = cacheResult?.currentDiskUsage {
                        Text("\(usage) bytes")
                    }
                }
            }, header: {
                Label("Disk", systemImage: "internaldrive")
            })
            Section(content: {
                HStack() {
                    Text("Configured Capacity")
                    Spacer()
                    if let capacity = cacheResult?.cacheConfiguration.memoryCapacityInMegabytes {
                        Text("\(capacity) MB")
                    }
                }
                HStack() {
                    Text("Capacity")
                    Spacer()
                    if let capacity = cacheResult?.memoryCapacity {
                        Text("\(capacity) bytes")
                    }
                }
                HStack() {
                    Text("Usage")
                    Spacer()
                    if let usage = cacheResult?.currentMemoryUsage {
                        Text("\(usage) bytes")
                    }
                }
            }, header: {
                Label("Memory", systemImage: "memorychip")
            })
            Section(content: {
                HStack() {
                    Text("URL")
                    Spacer()
                    if let url = cacheResult?.cachedResponse?.response.url {
                        Text(url.absoluteString)
                            .lineLimit(1)
                    }
                }
            }, header: {
                Label("Cached Response", systemImage: "tray.fill")
            })
        }.navigationTitle("Cache")
    }
}

public extension _Templates {
    struct ResultView<Content>: View where Content: View {
        let cacheResult: CacheResult?
        let content: () -> Content
        let retryRequest: () -> Void
        let newRequest: () -> Void

        public init(
            cacheResult: CacheResult?,
            content: @escaping () -> Content,
            retryRequest: @escaping () -> Void,
            newRequest: @escaping () -> Void
        ) {
            self.cacheResult = cacheResult
            self.content = content
            self.retryRequest = retryRequest
            self.newRequest = newRequest
        }

        public var body: some View {
            Color(uiColor: .systemGroupedBackground)
                .ignoresSafeArea()
                .overlay {
                    ScrollView {
                        LazyVStack(alignment: .leading) {
                            content()
                            Spacer()

//                            NavigationLink(destination: {
//                                CacheResultsView(cacheResult: cacheResult)
//                            }, label: {
//                                HStack() {
//                                    Label("Request", systemImage: "arrow.up.arrow.down")
//                                    Spacer()
//                                    Image(systemName: "chevron.forward")
//                                }
//                                .padding(.horizontal)
//                            })
//                            .padding(.vertical)
//                            .frame(maxWidth: .infinity)
//                            .background {
//                                RoundedRectangle(cornerRadius: 12)
//                                    .fill(.background)
//                            }
//                            .padding(.top)
                            NavigationLink(destination: {
                                CacheResultsView(cacheResult: cacheResult)
                            }, label: {
                                HStack() {
                                    Label("Cache", systemImage: "tray.full")
                                    Spacer()
                                    Image(systemName: "chevron.forward")
                                }
                                .padding(.horizontal)
                            })
                            .padding(.vertical)
                            .frame(maxWidth: .infinity)
                            .background {
                                RoundedRectangle(cornerRadius: 12)
                                    .fill(.background)
                            }
                            .padding(.vertical)
                            .disabled(cacheResult == nil)
                            Spacer()
//                            Button(action: {
//                                retryRequest()
//                            }, label: {
//                                HStack() {
//                                    Label("Reuse Configuration", systemImage: "arrow.rectanglepath")
//                                        .fontWeight(.bold)
//                                    Spacer()
//                                }
//                                .padding(.horizontal)
//                                .padding(.vertical)
//                                .frame(maxWidth: .infinity)
//                                .background {
//                                    RoundedRectangle(cornerRadius: 12)
//                                        .fill(.background)
//                                }
//                            })
//                            .padding(.top)
//                            Button(action: {
//                                newRequest()
//                            }, label: {
//                                HStack() {
//                                    Label("Use New Configuration", systemImage: "arrow.up")
//                                        .fontWeight(.bold)
//                                    Spacer()
//                                }
//                                .padding(.horizontal)
//                                .padding(.vertical)
//                                .frame(maxWidth: .infinity)
//                                .background {
//                                    RoundedRectangle(cornerRadius: 12)
//                                        .fill(.background)
//                                }
//                            })
//                            .padding(.bottom)
//                            Spacer()
                        }
                        .padding()
                    }
                }
        }
    }
}
