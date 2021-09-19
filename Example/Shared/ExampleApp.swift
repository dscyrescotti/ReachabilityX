//
//  ExampleApp.swift
//  Shared
//
//  Created by Dscyre Scotti on 12/09/2021.
//

import SwiftUI
import ReachabilityX

@main
struct ExampleApp: App {
    @ReachabilityObserved(hostname: "google.com") var reachability
    var body: some Scene {
        WindowGroup {
            #if os(macOS)
            GeometryReader { proxy in
                ContentView()
                    .frame(width: proxy.size.width, height: proxy.size.height)
            }
            .environmentReachability(reachability)
            #else
            ContentView()
                .environmentReachability(reachability)
            #endif
        }
    }
}
