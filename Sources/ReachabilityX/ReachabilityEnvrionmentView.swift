import SwiftUI
import Reachability

public struct ReachabilityEnvironmentView<Content: View>: View {
    @EnvironmentObject var reachability: ReachabilityObservable
    @Environment(\.changeConnectionAction) private var changeConnectionAction
    @Environment(\.throwErrorAction) private var throwErrorAction
    
    let content: (Connection, ReachabilityError?) -> Content
    
    @State private var connection: Connection = .unavailable
    @State private var error: ReachabilityError? = nil
    
    public var body: some View {
        content(connection, error)
            .onChangeConnection(reachability) { connection in
                self.connection = connection
                changeConnectionAction?(connection)
            }
            .onThrowError(reachability) { error in
                self.error = error
                throwErrorAction?(error)
            }
    }
    
    public init(@ViewBuilder content: @escaping (Connection, ReachabilityError?) -> Content) {
        self.content = content
    }
}

extension ReachabilityEnvironmentView {
    public func onChangeConnection(_ action: @escaping (Connection) -> Void) -> some View {
        self.environment(\.changeConnectionAction, action)
    }
    
    public func onThrowError(_ action: @escaping (ReachabilityError) -> Void) -> some View {
        self.environment(\.throwErrorAction, action)
    }
}
