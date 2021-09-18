import Combine
import Foundation
import Reachability

public typealias Connection = Reachability.Connection

public class ReachabilityObservable: ObservableObject {
    private var reachability: Reachability?
    private var cancellable: AnyCancellable?
    
    @Published public var connection: Connection = .unavailable
    @Published public var error: ReachabilityError?
    
    public var allowsCellularConnection: Bool {
        get { reachability?.allowsCellularConnection ?? true }
        set { reachability?.allowsCellularConnection = newValue }
    }
    
    public init(hostname: String? = nil) {
        do {
            if let hostname = hostname {
                self.reachability = try Reachability(hostname: hostname)
            } else {
                self.reachability = try Reachability()
            }
        } catch (let error) {
            self.error = error as? ReachabilityError
        }
    }
    
    public init(hostname: String? = nil, allowsCellularConnection: Bool = true) {
        do {
            if let hostname = hostname {
                self.reachability = try Reachability(hostname: hostname)
            } else {
                self.reachability = try Reachability()
            }
            self.allowsCellularConnection = allowsCellularConnection
        } catch (let error) {
            self.error = error as? ReachabilityError
        }
    }
    
    public init(hostname: String? = nil, allowsCellularConnection: Bool = true, queueQoS: DispatchQoS = .default, targetQueue: DispatchQueue? = nil, notificationQueue: DispatchQueue? = .main) {
        do {
            if let hostname = hostname {
                self.reachability = try Reachability(hostname: hostname, queueQoS: queueQoS, targetQueue: targetQueue, notificationQueue: notificationQueue)
            } else {
                self.reachability = try Reachability(queueQoS: queueQoS, targetQueue: targetQueue, notificationQueue: notificationQueue)
            }
            self.allowsCellularConnection = allowsCellularConnection
        } catch (let error) {
            self.error = error as? ReachabilityError
        }
    }
    
    public func start() {
        if cancellable == nil {
            cancellable = NotificationCenter.default
                .publisher(for: .reachabilityChanged, object: reachability)
                .map({ ($0.object as! Reachability).connection })
                .receive(on: DispatchQueue.main)
                .assign(to: \ReachabilityObservable.connection, on: self)
            do {
                try reachability?.startNotifier()
            } catch (let error) {
                self.error = error as? ReachabilityError
            }
        }
    }
    
    public func stop() {
        if cancellable != nil {
            reachability?.stopNotifier()
            cancellable = nil
        }
    }
    
    deinit {
        self.cancellable = nil
        self.reachability = nil
    }
}

