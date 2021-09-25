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
}
