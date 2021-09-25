//
//  ContentView.swift
//  Shared
//
//  Created by Dscyre Scotti on 12/09/2021.
//

import SwiftUI
import ReachabilityX

struct ContentView: View {
    @StateObject var reachability: Reachability = .init()
    var body: some View {
        NavigationView {
            Group {
                switch reachability.status {
                case .satisfied: icon(systemName: "wifi", label: "Connected!")
                default: icon(systemName: "wifi.slash", label: "Not Connected!")
                }
            }
            .onAppear {
                reachability.start()
            }
            .navigationTitle("ReachabilityX")
        }
    }
    
    func icon(systemName: String, label: String) -> some View {
        VStack {
            Image(systemName: systemName)
                .font(.system(.title2).bold())
            Text(label)
                .font(.system(.headline).bold())
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
