import SwiftUI
import Reachability

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7, *)
public struct ReachabilitySingleView<Content: View>: View {
    @StateObject var reachability: ReachabilityObservable = .init()
    @Environment(\.changeConnectionAction) private var changeConnectionAction
    @Environment(\.throwErrorAction) private var throwErrorAction
    
    let content: (Connection, ReachabilityError?) -> Content
    
    public var body: some View {
        content(reachability.connection, reachability.error)
            .onAppear {
                reachability.start()
            }
            .onDisappear {
                reachability.stop()
            }
            .onChangeConnection(reachability) { connection in
                changeConnectionAction?(connection)
            }
            .onThrowError(reachability) { error in
                throwErrorAction?(error)
            }
    }
    
    public init(@ViewBuilder content: @escaping (Connection, ReachabilityError?) -> Content) {
        self.content = content
    }
}

@available(iOS 14.0, macOS 11.0, tvOS 14.0, watchOS 7, *)
extension ReachabilitySingleView {
    public func onChangeConnection(_ action: @escaping (Connection) -> Void) -> some View {
        self.environment(\.changeConnectionAction, action)
    }
    
    public func onThrowError(_ action: @escaping (ReachabilityError) -> Void) -> some View {
        self.environment(\.throwErrorAction, action)
    }
}
