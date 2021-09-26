import XCTest
import Combine
@testable import ReachabilityX

final class ReachabilityXTests: XCTestCase {
    
    func testReachabilityStart() {
        let reachability = Reachability(notificationQueue: .global(qos: .default))
        let spy = ValueSpy(reachability.objectWillChange.eraseToAnyPublisher())
        XCTAssertEqual(spy.values.count, 0)
        reachability.start()
        sleep(1)
        XCTAssertEqual(spy.values.count, 1)
    }
    
    func testReachabilityStartAndStop() {
        let reachability = Reachability(notificationQueue: .global(qos: .default))
        let spy = ValueSpy(reachability.objectWillChange.eraseToAnyPublisher())
        XCTAssertEqual(spy.values.count, 0)
        reachability.start()
        sleep(1)
        XCTAssertEqual(spy.values.count, 1)
        reachability.stop()
        sleep(1)
        XCTAssertEqual(spy.values.count, 1)
    }
}

private class ValueSpy {
    private(set) var values: [Event] = []
    private var cancellable: AnyCancellable?
    init(_ publisher: AnyPublisher<Void, Never>) {
        self.values = []
        self.cancellable = publisher.sink { [weak self] _ in
            self?.values.append(Event())
        }
    }
}

private struct Event {
    let id: UUID = .init()
}
