import XCTest
@testable import Events

final class EventApiPostTests: XCTestCase {
    
    func testCheckin() {
        let api = EventsApiPost.checkin(name: "teste", email: "teste@teste.com", eventId: "123")
        let url = api.makeUrl()
        XCTAssertEqual(url?.scheme, "https")
        XCTAssertEqual(url?.host, "5b840ba5db24a100142dcd8c.mockapi.io")
        XCTAssertEqual(url?.path, "/api/checkin")
        
        let expectedBody: [String: Any] = ["name": "teste", "email": "teste@teste.com", "eventId": "123"]
        
        let body = api.body
        expectedBody.forEach { (arg) in
            let (key, value) = arg
            XCTAssertEqual(body[key] as? String, value as? String)
        }
    }
}
