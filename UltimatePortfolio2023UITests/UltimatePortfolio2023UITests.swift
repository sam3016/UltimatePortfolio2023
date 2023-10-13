//
//  UltimatePortfolio2023UITests.swift
//  UltimatePortfolio2023UITests
//
//  Created by Sam Hui on 2023/08/17.
//

import XCTest

extension XCUIElement {
    func clear() {
        guard let stringValue = self.value as? String else {
            XCTFail("Fail to clear text in XCUIElement")
            return
        }

        let deleteString = String(repeating: XCUIKeyboardKey.delete.rawValue, count: stringValue.count)
        typeText(deleteString)
    }
}

final class UltimatePortfolio2023UITests: XCTestCase {
    var app: XCUIApplication!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        app = XCUIApplication()
        app.launchArguments = ["enable-testing"]
        app.launch()
    }

    func testAppStartsWithNavigationBar() throws {
        XCTAssertTrue(app.navigationBars.element.exists, "There should be a navigation bar when the app launches.")
    }

    func testAppHasBasicButtonsOnLaunch() throws {
        XCTAssertTrue(app.navigationBars.buttons["Filters"].exists, "There should be a Filters button on launch.")
        XCTAssertTrue(app.navigationBars.buttons["New Issue"].exists, "There should be a New issue on launch.")
    }

    func testNoIssueAtStart() {
        XCTAssertEqual(app.cells.count, 0, "There should be 0 list rows initially.")
    }

    func testCreatingAndDeletingIssue() {
        for tapCount in 1...5 {
            app.buttons["New Issue"].tap()
            app.buttons["Issues"].tap()

            XCTAssertEqual(app.cells.count, tapCount, "There should be \(tapCount) rows in the list.")
        }

        for tapCount in (0...4).reversed() {
            app.cells.firstMatch.swipeLeft()
            app.buttons["Delete"].tap()

            XCTAssertEqual(app.cells.count, tapCount, "There should be \(tapCount) rows in the list.")
        }
    }

    func testingIssueTitleUpdatesCorrectly() {
        XCTAssertEqual(app.cells.count, 0, "There should be no rows initially.")

        app.buttons["New Issue"].tap()

        app.textFields["Enter the issue title here"].tap()
        app.textFields["Enter the issue title here"].clear()
        app.typeText("My New Issue")

        app.buttons["Issues"].tap()
        XCTAssertTrue(app.buttons["My New Issue"].exists, "A My New Issue cell should now exists.")
    }

    func testEditingIssuePriorityShowsIcon() {
        app.buttons["New Issue"].tap()
        app.buttons["Priority, Medium"].tap()
        app.buttons["High"].tap()
        app.buttons["Issues"].tap()

        let identifier = "New issue High Priority"
        XCTAssert(app.images[identifier].exists, "A high-priority issue needs an icon next to it.")
    }

    func testAllAwardsShowLockedAlert() {
        app.buttons["Filters"].tap()
        app.buttons["Showing awards"].tap()

        for award in app.scrollViews.buttons.allElementsBoundByIndex {
            if app.windows.element.frame.contains(award.frame) == false {
                app.swipeUp()
            }

            award.tap()
            XCTAssertTrue(app.alerts["Locked"].exists, "There should be a Locked alert showing this award.")
            app.buttons["OK"].tap()
        }
    }

    func testNoTagAtStart() {
        app.buttons["Filters"].tap()
        XCTAssertEqual(app.cells.count, 4, "There should be 4 list rows initially.")
    }

    func testCreatingAndDeletingTag() {
        app.buttons["Filters"].tap()
        for tapCount in 1...5 {
            app.buttons["Add tag"].tap()

            XCTAssertEqual(app.cells.count, tapCount + 4, "There should be \(tapCount + 4) rows in the list.")
        }

        for tapCount in (0...4).reversed() {
            app.buttons["New tag"].firstMatch.swipeLeft()
            app.buttons["Delete"].tap()

            XCTAssertEqual(app.cells.count, tapCount + 4, "There should be \(tapCount + 4) rows in the list.")
        }
    }

    func testRenamingTag() {
        app.buttons["Filters"].tap()
        app.buttons["Add tag"].tap()

        app.buttons["New tag"].firstMatch.press(forDuration: 1)
        app.buttons["Rename"].tap()

        app.textFields["New tag"].tap()
        app.textFields["New tag"].clear()
        app.typeText("New tag 1")
        app.buttons["OK"].tap()

        XCTAssertTrue(app.buttons["New tag 1"].exists, "A New tag 1 should now exists.")
    }

    func testSearchingIssue() {
        for tapCount in 1...5 {
            app.buttons["New Issue"].tap()
            app.textFields["Enter the issue title here"].tap()
            app.textFields["Enter the issue title here"].clear()
            app.typeText("New issue\(tapCount)")
            app.buttons["Issues"].tap()
        }

        app.searchFields["Filter issues, or type # to add tags"].tap()
        app.typeText("1")
        XCTAssertEqual(app.cells.count, 1, "There should be 1 row in the list.")
    }

    func testFilteringIssue() {
//        for tapCount in 1...5 {
//            app.buttons["New Issue"].tap()
//            app.textFields["Enter the issue title here"].tap()
//            app.textFields["Enter the issue title here"].clear()
//            app.typeText("New issue\(tapCount)")
//            app.buttons["Issues"].tap()
//        }

        // app.popUpButtons["Filter"].tap()
    }

    func testAddingTagToIssue() {
        app.buttons["Filters"].tap()
        for tapCount in 1...5 {
            app.buttons["Add tag"].tap()
            app.buttons["New tag"].firstMatch.press(forDuration: 1)
            app.buttons["Rename"].tap()

            app.textFields["New tag"].tap()
            app.textFields["New tag"].clear()
            app.typeText("New tag \(tapCount)")
            app.buttons["OK"].tap()
        }
        app.buttons["Recent Issues"].tap()
        app.buttons["New Issue"].tap()
        app.buttons["Not tags"].doubleTap()
        app.popUpButtons["New tag 1"].tap()
        XCTAssertEqual(app.cells.count, 1, "There should be 1 row in the list.")
    }
}
