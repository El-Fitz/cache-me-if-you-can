//
//  File.swift
//  
//
//  Created by Thomas Léger on 20/08/2023.
//

import Foundation
import Cache

public struct Models {
}

public extension Models {
    struct Cache {
        public enum Policy: String, CaseIterable, Equatable, Identifiable {
            case useProtocolCachePolicy
            case reloadIgnoringLocalCacheData
            case reloadIgnoringLocalAndRemoteCacheData
            case reloadIgnoringCacheData
            case returnCacheDataElseLoad
            case returnCacheDataDontLoad
            case reloadRevalidatingCacheData

            public var id: String { self.rawValue }
        }

        public enum Directory: String, CaseIterable, Equatable, Identifiable {
            case defaultCacheDirectory
            case tempDirectory
            case applicationSupportDirectory
            case documentsDirectory

            public var id: String { self.rawValue }
        }

        public static func title(for cacheDirectory: Directory) -> String {
            switch cacheDirectory {
            case .defaultCacheDirectory:        return "Default Cache Directory"
            case .tempDirectory:                return "Temp Directory"
            case .applicationSupportDirectory:  return "Application Support Directory"
            case .documentsDirectory:           return "Documents Directory"
            }
        }

        public static func title(for cachePolicy: Policy) -> String {
            switch cachePolicy {
            case .useProtocolCachePolicy:                   return "Use Protocol Cache Policy (Default)"
            case .reloadRevalidatingCacheData:              return "Reload Revalidating Cache Data"
            case .reloadIgnoringCacheData:                  return "Reload Ignoring Cache Data"
            case .reloadIgnoringLocalAndRemoteCacheData:    return "Reload Ignoring Local And Remote Cache Data"
            case .reloadIgnoringLocalCacheData:             return "Reload Ignoring Local Cache Data"
            case .returnCacheDataDontLoad:                  return "Return CacheData Don't Load"
            case .returnCacheDataElseLoad:                  return "Return Cache Data Else Load"
            }
        }

        public static func directoryFor(_ directory: Directory) -> CacheConfiguration.Directory {
            switch directory {
            case .defaultCacheDirectory:        return .defaultCacheDirectory
            case .tempDirectory:                return .tempDirectory
            case .applicationSupportDirectory:  return .applicationSupportDirectory
            case .documentsDirectory:           return .documentsDirectory
            }
        }

        public static func directoryFor(_ directory: CacheConfiguration.Directory) -> Directory {
            switch directory {
            case .defaultCacheDirectory:        return .defaultCacheDirectory
            case .tempDirectory:                return .tempDirectory
            case .applicationSupportDirectory:  return .applicationSupportDirectory
            case .documentsDirectory:           return .documentsDirectory
            }
        }

        public static func policyFor(_ policy: Policy) -> NSURLRequest.CachePolicy {
            switch policy {
            case .useProtocolCachePolicy:                   return .useProtocolCachePolicy
            case .reloadIgnoringCacheData:                  return .reloadIgnoringCacheData
            case .reloadIgnoringLocalAndRemoteCacheData:    return .reloadIgnoringLocalAndRemoteCacheData
            case .reloadIgnoringLocalCacheData:             return .reloadIgnoringLocalCacheData
            case .reloadRevalidatingCacheData:              return .reloadRevalidatingCacheData
            case .returnCacheDataDontLoad:                  return .returnCacheDataDontLoad
            case .returnCacheDataElseLoad:                  return .returnCacheDataElseLoad
            }
        }

        public static func policyFor(_ policy: NSURLRequest.CachePolicy) -> Policy {
            switch policy {
            case .useProtocolCachePolicy:                   return .useProtocolCachePolicy
            case .reloadIgnoringCacheData:                  return .reloadIgnoringCacheData
            case .reloadIgnoringLocalAndRemoteCacheData:    return .reloadIgnoringLocalAndRemoteCacheData
            case .reloadIgnoringLocalCacheData:             return .reloadIgnoringLocalCacheData
            case .reloadRevalidatingCacheData:              return .reloadRevalidatingCacheData
            case .returnCacheDataDontLoad:                  return .returnCacheDataDontLoad
            case .returnCacheDataElseLoad:                  return .returnCacheDataElseLoad
            }
        }
    }
}
