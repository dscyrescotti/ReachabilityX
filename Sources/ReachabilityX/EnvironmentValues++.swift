import SwiftUI
import Reachability

extension EnvironmentValues {
    var changeConnectionAction: ((Connection) -> Void)? {
        get { self[ChangeConnectionActionEnvironmentKey.self] }
        set { self[ChangeConnectionActionEnvironmentKey.self] = newValue }
    }
    
    var throwErrorAction: ((ReachabilityError) -> Void)? {
        get { self[ThrowErrorActionEnvironmentKey.self] }
        set { self[ThrowErrorActionEnvironmentKey.self] = newValue }
    }
}
