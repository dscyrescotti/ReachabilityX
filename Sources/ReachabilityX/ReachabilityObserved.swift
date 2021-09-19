import Combine
import SwiftUI
import Foundation
import Reachability

@propertyWrapper
public struct ReachabilityObserved {
    
    @ObservedObject private var observable: ReachabilityObservable
    
    public var wrappedValue: ReachabilityObservable {
        get { observable }
    }
    
    public init(hostname: String? = nil) {
        self.observable = .init(hostname: hostname)
    }
    
    public init(hostname: String? = nil, allowsCellularConnection: Bool = true) {
        self.observable = .init(hostname: hostname, allowsCellularConnection: allowsCellularConnection)
    }
    
    public init(hostname: String? = nil, allowsCellularConnection: Bool = true, queueQoS: DispatchQoS = .default, targetQueue: DispatchQueue? = nil, notificationQueue: DispatchQueue? = .main) {
        self.observable = .init(hostname: hostname, allowsCellularConnection: allowsCellularConnection, queueQoS: queueQoS, targetQueue: targetQueue, notificationQueue: notificationQueue)
    }
}
