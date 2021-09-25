import SwiftUI
import Network

public struct ReachabilityView<Content: View>: View {
    @EnvironmentObject private var reachability: Reachability
    
    @Environment(\.changeInterfaceTypeAction) private var changeInterfaceTypeAction
    @Environment(\.changePathAction) private var changePathAction
    @Environment(\.changeStatusAction) private var changeStatusAction
    
    private let content: (Reachability) -> Content
    public var body: some View {
        content(reachability)
            .onReceive(reachability.objectWillChange, perform: {
                changeInterfaceTypeAction?(reachability.interfaceType)
                changeStatusAction?(reachability.status)
                changePathAction?(reachability.path)
            })
    }
    
    public init(@ViewBuilder content: @escaping (NWPath) -> Content) {
        self.content = { reachability in
            content(reachability.path)
        }
    }
    
    public init(@ViewBuilder content: @escaping (Status) -> Content) {
        self.content = { reachability in
            content(reachability.status)
        }
    }
    
    public init(@ViewBuilder content: @escaping (InterfaceType) -> Content) {
        self.content = { reachability in
            content(reachability.interfaceType)
        }
    }
    
    public init(@ViewBuilder content: @escaping (Status, InterfaceType) -> Content) {
        self.content = { reachability in
            content(reachability.status, reachability.interfaceType)
        }
    }
}
