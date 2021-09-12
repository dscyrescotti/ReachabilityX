import Combine
import Foundation
import Reachability

@propertyWrapper
public class ReachabilityObserved {
    private let observable: ReachabilityObservable
    
    public var wrappedValue: ReachabilityObservable {
        get { observable }
    }
    
    public init(hostname: String? = nil, allowsCellularConnection: Bool = true, queueQoS: DispatchQoS = .default, targetQueue: DispatchQueue? = nil, notificationQueue: DispatchQueue? = .main) {
        self.observable = .init(hostname: hostname, queueQoS: queueQoS, targetQueue: targetQueue, notificationQueue: notificationQueue)
        self.observable.allowsCellularConnection = allowsCellularConnection
    }
}
