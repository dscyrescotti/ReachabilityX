# ReachabilityX
__ReachabilityX__ is designed to provide an easy way to observe the network changes for SwiftUI.

***Note**: Currently, ReachabilityX is built on top of [__Reachability.swift__](https://github.com/ashleymills/Reachability.swift). According to the documentation of Reachability.swift, it is said that it is compatible with **iOS** (8.0 - 12.0), **OSX** (10.9 - 10.14) and **tvOS** (9.0 - 12.0). But it has been deprecated yet and it is still working. Later, I'll consider to use `NWPathMonitor` from Apple's `Network` framework.*

## Requirements
-   iOS 13.0+ / macOS 10.15+ / tvOS 13.0+ / watchOS 6.0+
-   Swift 5.3+

## Installation
### Swift Package Manager
Add it as a dependency within your  `Package.swift`,
```
dependencies: [
    .package(url: "https://github.com/dscyrescotti/ReachabilityX", from: "0.1.0")
]
```
Currently, **ReachabilityX** can only be installed via **Swift Package Manager**.

## Usage
 __ReachabilityX__ comes with `ReachabilityView` that is needed to supply `ReachabilityObservable` object by its parent or ancestor. It is pretty handy to use when network changes are needed to observe across multiple views.
 
### Example 1
Firstly, you need to create a instance of `ReachabilityObservable` inside  for sharing via    `environmentObject(_:)`.
```swift
@main
struct TestApp: App {
    @ObservedObject var reachability: ReachabilityObservable = .init(hostname: "google.com")
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentReachability(reachability)
        }
    }
}
```
Now, you can easily implement your presentation logic inside `ReachabilityView` and also interact with your business logic using `onChangeConnection(_:)` and `onThrowError(_:)`.
```swift
struct ContentView: View {
    var body: some View {
        ReachabilityView { connection, error in
            // some presentation logic
        }
        .onChangeConnection { connection in
            // some business logic
        }
        .onThrowError { error in
            // some business logic
        }
    }
}
```

### Example 2
__ReachabiliyX__ also allows you to create your own `ReachabilityObservable` instance by declaring inside SwiftUI view to observe the network changes. 
```swift
struct ContentView: View {
    @StateObject var reachability: ReachabilityObservable = .init(hostname: "google.com")
    var body: some View {
        Group {
            switch reachability.connection {
            case .wifi, .cellular:
                Text("Available")
            case .unavailable, .none:
                Text("Unavailable")
            }
        }
        .onAppear {
	        // start listening the network changes
            reachability.start() 
        }
        .onDisappear {
	        // stop listening the network changes
            reachability.stop()
        }
    }
}
```
***Note**: Don't forget to call `start()` when you start observing the network changes.*

## Author
**Dscyre Scotti** (**[@dscyrescotti](https://twitter.com/dscyrescotti)**)

## Contributions

**ReachabilityX**  welcomes all developers to contribute if you have any idea to improve and open an issue if you find any kind of bug.

## License

ReachabilityX is available under the MIT license. See the  [LICENSE](https://github.com/dscyrescotti/ReachabilityX/blob/main/LICENSE)  file for more info.