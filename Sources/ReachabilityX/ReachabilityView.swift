import SwiftUI
import Reachability

public struct ReachabilityView<Content: View>: View {
    @EnvironmentObject var reachability: ReachabilityObservable
    @Environment(\.changeConnectionAction) private var changeConnectionAction
    @Environment(\.throwErrorAction) private var throwErrorAction
    
    let content: (Connection, ReachabilityError?) -> Content
    
    public var body: some View {
        content(reachability.connection, reachability.error)
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

extension ReachabilityView {
    public func onChangeConnection(_ action: @escaping (Connection) -> Void) -> some View {
        self.environment(\.changeConnectionAction, action)
    }
    
    public func onThrowError(_ action: @escaping (ReachabilityError) -> Void) -> some View {
        self.environment(\.throwErrorAction, action)
    }
}
