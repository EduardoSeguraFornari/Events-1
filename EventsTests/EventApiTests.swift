import XCTest
@testable import Events

final class EventApiTests: XCTestCase {
    
    func testEvents() {
        let url = EventsApi.events.makeUrl()
        XCTAssertEqual(url?.scheme, "https")
        XCTAssertEqual(url?.host, "5b840ba5db24a100142dcd8c.mockapi.io")
        XCTAssertEqual(url?.path, "/api/events")
    }
    
    func testEvent() {
        let url = EventsApi.event(id: "123").makeUrl()
        XCTAssertEqual(url?.scheme, "https")
        XCTAssertEqual(url?.host, "5b840ba5db24a100142dcd8c.mockapi.io")
        XCTAssertEqual(url?.path, "/api/events/123")
    }
}
