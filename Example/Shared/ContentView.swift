//
//  ContentView.swift
//  Shared
//
//  Created by Dscyre Scotti on 12/09/2021.
//

import SwiftUI
import ReachabilityX

struct ContentView: View {
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
        .onChangeConnection { connection in
            print(connection)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
