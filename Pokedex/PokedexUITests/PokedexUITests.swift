//
//  PokedexUITests.swift
//  PokedexUITests
//
//  Created by Elano Vasconcelos on 02/02/24.
//

import XCTest

final class PokedexUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testOpenDetail() throws {
        let app = XCUIApplication()
        app.launch()

        // Wait for the list to load and then tap the first item
        let firstListItem = app.cells.element(boundBy: 0)
        let exists = NSPredicate(format: "exists == 1")
        
        expectation(for: exists, evaluatedWith: firstListItem, handler: nil)
        waitForExpectations(timeout: 5, handler: nil)
        
        firstListItem.tap()
        
        let detailTitle = app.staticTexts["ListDetailView_Title"]
        XCTAssertTrue(detailTitle.exists)
        
        XCTAssertEqual(detailTitle.label, "Bulbasaur #001")
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, watchOS 7.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}
