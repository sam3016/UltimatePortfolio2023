//
//  PerformanceTests.swift
//  UltimatePortfolio2023Tests
//
//  Created by Sam Hui on 2023/08/05.
//

import CoreData
import XCTest
@testable import UltimatePortfolio2023

final class PerformanceTests: BaseTestCase {
    func testAwardCalculationPerformance() {
        for _ in 1...100 {
            dataController.createSampleData()
        }

        let awards = Array(repeating: Award.allAwards, count: 25).joined()
        XCTAssertEqual(awards.count, 500, "This checks the awards count is constant. Change this if you add awards.")

        measure {
            _ = awards.filter(dataController.hasEarned)
        }
    }
}
