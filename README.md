# ReachabilityX
__ReachabilityX__ is built using `NWPathMonitor` from Apple's `Network` framework to provide an easy way to observe the network changes for SwiftUI.

## Requirements
-   iOS 13.0+ / macOS 10.15+ / tvOS 13.0+ / watchOS 6.0+
-   Swift 5.3+

## Installation
### Swift Package Manager
Add it as a dependency within your  `Package.swift`,
```
dependencies: [
    .package(url: "https://github.com/dscyrescotti/ReachabilityX", from: "1.0.0")
]
```
Currently, **ReachabilityX** can only be installed via **Swift Package Manager**.

## Usage
__ReachabilityX__ comes with `ReachabilityView` that exposes `Reachability` object supplied from its parent or ancestor. It is pretty handy to use when network changes are needed to observe across multiple views.
 
### Example 1
Firstly, you need to create an instance of `Reachability` inside the entry point of an app for the purpose of sharing it across multiple views via `environmentObject(_:)`.
```swift
@main
struct TestApp: App {
    @ObservedObject var reachability: Reachability = .init()
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(reachability)
                .onAppear {
                    reachability.start()
                }
        }
    }
}
```
Now, you can easily implement your presentation logic inside `ReachabilityView` and also implement your business logic using `onChangeStatus(action:)`,  `onChangeInterfaceType(action:)` and `onChangePath(action:)`.
```swift
struct ContentView: View {
    var body: some View {
        ReachabilityView { (status: Status) in
            // some presentation logic
        }
        .onChangeStatus { status in
            // some business logic associated with status changes
        }
        .onChangeInterfaceType { interfaceType in
            // some business logic associated with interface type changes
        }
        .onChangePath { path in
            // some business logic associated with path changes
        }
    }
}
```
`ReachabilityView` comes with a couple of initializers that allows you to construct your desired views inside closures with different parameters. 
```swift
// use it when you are only interested in status
ReachabilityView { (status: Status) in
    // some presentation logic associated with status changes
}

// use it when you are only interested in interface type
ReachabilityView { (interfaceType: InterfaceType) in
    // some presentation logic associated with interface changes
}

// use it when you are interested in both of status and interface type
ReachabilityView { (status: Status, interfaceType: InterfaceType) in
    // some presentation logic associated with status and interface type changes
}

// use it when you need to know the whole network path object
ReachabilityView { (path: NWPath) in
    // some presentation logic associated with network path
}
```

### Example 2
__ReachabiliyX__ also allows you to create your own `Reachability` instance by declaring inside SwiftUI view to observe the network changes. 
```swift
struct ContentView: View {
    @StateObject var reachability: Reachability = .init()
    var body: some View {
        Group {
            switch reachability.status {
            case .satisfied: Text("Connected!")
            default: Text("Not Connected!")
            }
        }
        .onAppear {
            reachability.start()
        }
        .onDisappear {
            reachability.stop()
        }
        .onChangeInterfaceType(reachability) { interfaceType in
            // some business logic
        }
    }
}
```

### Start and stop monitoring network changes
To obtain network path updates, you need to call `start()` method to begin observing network changes. If you want to stop observing changes, you have to call `stop()` method. This will no longer monitor any network changes.

## Author
**Dscyre Scotti** (**[@dscyrescotti](https://twitter.com/dscyrescotti)**)

## Contributions

**ReachabilityX**  welcomes all developers to contribute if you have any idea to improve and open an issue if you find any kind of bug.

## License

ReachabilityX is available under the MIT license. See the  [LICENSE](https://github.com/dscyrescotti/ReachabilityX/blob/main/LICENSE)  file for more info.