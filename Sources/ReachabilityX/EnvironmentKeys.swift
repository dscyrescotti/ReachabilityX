import SwiftUI
import Reachability

struct ChangeConnectionActionEnvironmentKey: EnvironmentKey {
    static var defaultValue: ((Connection) -> Void)? = nil
}

struct ThrowErrorActionEnvironmentKey: EnvironmentKey {
    static var defaultValue: ((ReachabilityError) -> Void)? = nil
}
