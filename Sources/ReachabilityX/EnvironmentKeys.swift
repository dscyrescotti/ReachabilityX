import SwiftUI
import Network

struct ChangeInterfaceTypeActionEnvironmentKey: EnvironmentKey {
    static var defaultValue: ((InterfaceType) -> Void)? = nil
}

struct ChangePathActionEnvironmentKey: EnvironmentKey {
    static var defaultValue: ((NWPath) -> Void)? = nil
}

struct ChangeStatusActionEnvironmentKey: EnvironmentKey {
    static var defaultValue: ((Status) -> Void)? = nil
}
