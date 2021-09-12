import SwiftUI
import Reachability

public struct ReachabilityObservingView<Content: View>: View {
    @ReachabilityObserved private var reachability
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
    
    public init(hostname: String? = nil, allowsCellularConnection: Bool = true, queueQoS: DispatchQoS = .default, targetQueue: DispatchQueue? = nil, notificationQueue: DispatchQueue? = .main, @ViewBuilder content: @escaping (Connection, ReachabilityError?) -> Content) {
        self._reachability = ReachabilityObserved(hostname: hostname, allowsCellularConnection: allowsCellularConnection, queueQoS: queueQoS, targetQueue: targetQueue, notificationQueue: notificationQueue)
        self.content = content
    }
}

extension ReachabilityObservingView {
    public func onChangeConnection(_ action: @escaping (Connection) -> Void) -> some View {
        self.environment(\.changeConnectionAction, action)
    }
    
    public func onThrowError(_ action: @escaping (ReachabilityError) -> Void) -> some View {
        self.environment(\.throwErrorAction, action)
    }
}
