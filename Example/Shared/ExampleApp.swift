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
    @ObservedObject var reachability: ReachabilityObservable = .init(hostname: "google.com")
    var body: some Scene {
        WindowGroup {
            #if os(macOS)
            GeometryReader { proxy in
                AppView()
                    .frame(width: proxy.size.width, height: proxy.size.height)
            }
            .environmentReachability(reachability)
            #else
            AppView()
                .environmentReachability(reachability)
            #endif
        }
    }
}
