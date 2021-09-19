//
//  AppView.swift
//  Shared
//
//  Created by Dscyre Scotti on 12/09/2021.
//

import SwiftUI
import ReachabilityX

struct AppView: View {
    @State private var selection: Int? = 0
    var body: some View {
        NavigationView {
            List {
                NavigationLink(destination: ListeningView(image: "star.fill"), tag: 0, selection: $selection) {
                    Label("Star", systemImage: "star.fill")
                }
                NavigationLink(destination: ListeningView(image: "heart.fill"), tag: 1, selection: $selection) {
                    Label("Heart", systemImage: "heart.fill")
                }
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("ReachabilityX")
        }
    }
}

struct ListeningView: View {
    let image: String
    var body: some View {
        ReachabilityView { connection, error in
            Group {
                switch connection {
                case .wifi, .cellular:
                    Label {
                        Text("Avaliable")
                            .font(.system(size: 30).bold())
                    } icon: {
                        Image(systemName: "wifi")
                    }
                    .foregroundColor(.green)
                case .unavailable, .none:
                    Label {
                        Text("Unavaliable")
                            .font(.system(size: 30).bold())
                    } icon: {
                        Image(systemName: "wifi.exclamationmark")
                    }
                    .foregroundColor(.gray)
                }
            }
            .font(.system(size: 40).bold())
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .overlay(Image(systemName: image).foregroundColor(.yellow).font(.system(size: 20)).padding(), alignment: .bottomTrailing)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        AppView()
    }
}
