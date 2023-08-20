import SwiftUI

import API
import Components

@main
public struct CatchMeIfYouCanApp: App {
    public init() { }

    public var body: some Scene {
        WindowGroup {
            Components.Modules.Home()
        }
    }
}
