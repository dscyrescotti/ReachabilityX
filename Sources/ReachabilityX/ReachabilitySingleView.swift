import SwiftUI
import Reachability

struct ReachabilitySingleView<Content: View>: View {
    @ReachabilityObserved var reachability: ReachabilityObservable
    @Environment(\.changeConnectionAction) private var changeConnectionAction
    @Environment(\.throwErrorAction) private var throwErrorAction
    
    let content: (Connection, ReachabilityError?) -> Content
    
    public var body: some View {
        content(reachability.connection, reachability.error)
            .onAppear {
                self.reachability.start()
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
        debugPrint("init")
    }
}

extension ReachabilitySingleView {
    public func onChangeConnection(_ action: @escaping (Connection) -> Void) -> some View {
        self.environment(\.changeConnectionAction, action)
    }
    
    public func onThrowError(_ action: @escaping (ReachabilityError) -> Void) -> some View {
        self.environment(\.throwErrorAction, action)
    }
}
