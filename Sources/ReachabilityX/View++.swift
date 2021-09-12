import SwiftUI
import Reachability

extension View {
    public func onChangeConnection(_ reachability: ReachabilityObservable, _ action: @escaping (Connection) -> Void) -> some View {
        self.onReceive(reachability.$connection, perform: action)
    }
    
    public func onThrowError(_ reachability: ReachabilityObservable, _ action: @escaping (ReachabilityError) -> Void) -> some View {
        self.onReceive(reachability.$error) { error in
            if let error = error {
                action(error)
            }
        }
    }
    
    public func environmentReachability(_ reachability: ReachabilityObservable, isObserving: Bool = true) -> some View {
        self.environmentObject(reachability)
            .onAppear {
                if isObserving {
                    reachability.start()
                }
            }
    }
}
