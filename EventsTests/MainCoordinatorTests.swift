import XCTest
@testable import Events

final class MainCoordinatorTest: XCTestCase {
    
    var navigator: MockNavigator!
    var mainCoodinator: MainCoordinator!
    
    override func setUp() {
        navigator = MockNavigator()
        mainCoodinator = MainCoordinator(navigationController: navigator)
    }
    
    func testStart() {
        let expectation = XCTestExpectation(description: "startCoordinator")
        
        navigator.pushedViewController = { viewControlller in
            XCTAssert(viewControlller is EventListViewController)
            expectation.fulfill()
        }
        
        mainCoodinator.start()
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testSelectEvent() {
        let expectation = XCTestExpectation(description: "didSelectedEvent")
        
        navigator.pushedViewController = { viewControlller in
            XCTAssert(viewControlller is EventDetailViewController)
            expectation.fulfill()
        }
        
        let event = EventViewModel(Event(id: "123",
                                         title: "teste",
                                         image: "teste",
                                         description: "teste"))
        
        mainCoodinator.didSelected(event: event)
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testShareActionTriggered() {
        let expectation = XCTestExpectation(description: "shareActionTriggered")
        
        navigator.presentedViewController = { viewController in
            XCTAssert(viewController is UIActivityViewController)
            expectation.fulfill()
        }
        
        mainCoodinator.shareActionTriggered(text: "test")
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testCheckinActionTriggered() {
        let expectation = XCTestExpectation(description: "checkinActionTriggered")
        
        navigator.presentedViewController = { viewController in
            XCTAssert(viewController is UINavigationController)
            expectation.fulfill()
        }
        
        mainCoodinator.checkinActionTriggered(eventId: "123")
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testCancelActionTriggered() {
        let expectation = XCTestExpectation(description: "cancelActionTriggered")
        
        navigator.dimissed = {
            expectation.fulfill()
        }
        
        mainCoodinator.cancelActionTriggered()
        
        wait(for: [expectation], timeout: 0.1)
    }
    
    func testDoneActionTriggered() {
        let expectation = XCTestExpectation(description: "doneActionTriggered")
        
        navigator.dimissed = {
            expectation.fulfill()
        }
        
        let presentExpectation = XCTestExpectation(description: "presentMessage")
        
        navigator.presentedViewController = { viewController in
            XCTAssert(viewController is UIAlertController)
            presentExpectation.fulfill()
        }
        
        mainCoodinator.doneActionTriggered()
        
        wait(for: [expectation, presentExpectation], timeout: 0.1)
    }
    
    func testShowMessage() {
        let presentExpectation = XCTestExpectation(description: "presentMessage")
        
        let navigator = MockNavigator()
        
        navigator.presentedViewController = { viewController in
            XCTAssert(viewController is UIAlertController)
            presentExpectation.fulfill()
        }
        
        mainCoodinator.checkinNavigationController = navigator
        
        mainCoodinator.showMessage("teste")
        
        wait(for: [presentExpectation], timeout: 0.1)
    }
    
}
