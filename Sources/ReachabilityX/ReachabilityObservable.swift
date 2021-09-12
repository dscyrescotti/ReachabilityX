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
    
    public init(hostname: String?, queueQoS: DispatchQoS = .default, targetQueue: DispatchQueue? = nil, notificationQueue: DispatchQueue? = .main) {
        do {
            if let hostname = hostname {
                self.reachability = try Reachability(hostname: hostname, queueQoS: queueQoS, targetQueue: targetQueue, notificationQueue: notificationQueue)
            } else {
                self.reachability = try Reachability(queueQoS: queueQoS, targetQueue: targetQueue, notificationQueue: notificationQueue)
            }
        } catch (let error) {
            self.error = error as? ReachabilityError
        }
        self.cancellable = NotificationCenter.default
            .publisher(for: .reachabilityChanged, object: reachability)
            .map({ ($0.object as! Reachability).connection })
            .assign(to: \ReachabilityObservable.connection, on: self)
    }
    
    public func start() {
        do {
            try reachability?.startNotifier()
        } catch (let error) {
            self.error = error as? ReachabilityError
        }
    }
    
    public func stop() {
        reachability?.stopNotifier()
    }
    
    deinit {
        self.cancellable = nil
        self.reachability = nil
    }
}

