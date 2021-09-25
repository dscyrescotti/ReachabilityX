import Combine
import Network
import Foundation

final public class Reachability: ObservableObject {
    private var monitor: NWPathMonitor = .init()
    private var queue: DispatchQueue
    private var notificationQueue: DispatchQueue
    private var startsMonitoring: Bool = false
    
    public var status: Status {
        get { path.status }
    }
    public var path: NWPath {
        get { monitor.currentPath }
    }
    public var interfaceType: InterfaceType {
        get { usesInterfaceType() }
    }
    
    public init(queueQoS: DispatchQoS = .default, targetQueue: DispatchQueue? = nil, notificationQueue: DispatchQueue = .main) {
        self.queue = DispatchQueue(label: "queue.reachability", qos: queueQoS, target: targetQueue)
        self.notificationQueue = notificationQueue
        self.monitor.pathUpdateHandler = { [weak self] path in
            self?.notificationQueue.async { [weak self] in
                self?.objectWillChange.send()
            }
        }
    }
    
    public func start() {
        if !startsMonitoring {
            monitor.start(queue: queue)
            startsMonitoring = true
        }
    }
    
    public func stop() {
        if startsMonitoring {
            monitor.cancel()
            startsMonitoring = false
        }
    }
    
    private func usesInterfaceType() -> InterfaceType {
        if path.usesInterfaceType(.wifi) {
            return .wifi
        } else if path.usesInterfaceType(.cellular) {
            return .cellular
        } else if path.usesInterfaceType(.wiredEthernet) {
            return .wiredEthernet
        } else if path.usesInterfaceType(.loopback) {
            return .loopback
        } else if path.usesInterfaceType(.other) {
            return .other
        } else {
            return .none
        }
    }
}
