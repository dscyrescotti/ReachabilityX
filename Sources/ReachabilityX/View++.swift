import SwiftUI
import Network

public extension View {
    func onChangeInterfaceType(action: @escaping (InterfaceType) -> Void) -> some View {
        self.environment(\.changeInterfaceTypeAction, action)
    }
    
    func onChangePath(action: @escaping (NWPath) -> Void) -> some View {
        self.environment(\.changePathAction, action)
    }
    
    func onChangeStatus(action: @escaping (Status) -> Void) -> some View {
        self.environment(\.changeStatusAction, action)
    }
    
    func onChangeInterfaceType(_ reachability: Reachability, action: @escaping (InterfaceType) -> Void) -> some View {
        self.onReceive(reachability.objectWillChange, perform: {
            action(reachability.interfaceType)
        })
    }
    
    func onChangePath(_ reachability: Reachability, action: @escaping (NWPath) -> Void) -> some View {
        self.onReceive(reachability.objectWillChange, perform: {
            action(reachability.path)
        })
    }
    
    func onChangeStatus(_ reachability: Reachability, action: @escaping (Status) -> Void) -> some View {
        self.onReceive(reachability.objectWillChange, perform: {
            action(reachability.status)
        })
    }
}
