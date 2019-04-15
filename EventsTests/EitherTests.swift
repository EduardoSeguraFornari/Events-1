import XCTest
@testable import Events

final class EitherTests: XCTestCase {

    func testLeft() {
        let either: Either<Int, String> = .left(1)
        
        XCTAssertNotNil(either.left)
        XCTAssertNil(either.right)
    }
    
    func testRight() {
        let either: Either<Int, String> = .right("1")
        
        XCTAssertNotNil(either.right)
        XCTAssertNil(either.left)
    }

}
