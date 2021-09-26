import SwiftUI
import Network

extension EnvironmentValues {
    var changeInterfaceTypeAction: ((InterfaceType) -> Void)? {
        get { self[ChangeInterfaceTypeActionEnvironmentKey.self] }
        set { self[ChangeInterfaceTypeActionEnvironmentKey.self] = newValue }
    }
    
    var changePathAction: ((NWPath) -> Void)? {
        get { self[ChangePathActionEnvironmentKey.self] }
        set { self[ChangePathActionEnvironmentKey.self] = newValue }
    }
    
    var changeStatusAction: ((Status) -> Void)? {
        get { self[ChangeStatusActionEnvironmentKey.self] }
        set { self[ChangeStatusActionEnvironmentKey.self] = newValue }
    }
}
