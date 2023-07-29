//
//  DevelopmentTests.swift
//  UltimatePortfolio2023Tests
//
//  Created by Sam Hui on 2023/07/19.
//

import CoreData
import XCTest
@testable import UltimatePortfolio2023

final class DevelopmentTests: BaseTestCase {
    func testSampleDataCreationWorks() {
        dataController.createSampleData()

        XCTAssertEqual(dataController.count(for: Tag.fetchRequest()), 5, "There should be 5 sample tags.")
        XCTAssertEqual(dataController.count(for: Issue.fetchRequest()), 50, "There should be 50 sample issues.")
    }

    func testDeleteAllClearsEverything() {
        dataController.createSampleData()
        dataController.deleteAll()

        XCTAssertEqual(dataController.count(for: Tag.fetchRequest()), 0, "deleteAll() should leave 0 sample tags.")
        XCTAssertEqual(dataController.count(for: Issue.fetchRequest()), 0, "deleteAll() should leave 0 sample issues.")
    }

    func testExampleTagHasNoIssue() {
        let tag = Tag.example
        XCTAssertEqual(tag.issues?.count, 0, "The exmaple tag should have 0 issues.")
    }

    func testExampleIssueIsHighPriority() {
        let issue = Issue.example
        XCTAssertEqual(issue.priority, 2, "The example issue should be in high priority.")
    }
}
