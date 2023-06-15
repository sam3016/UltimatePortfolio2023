//
//  UltimatePortfolio2023Tests.swift
//  UltimatePortfolio2023Tests
//
//  Created by Sam Hui on 2023/06/15.
//

import CoreData
import XCTest
@testable import UltimatePortfolio2023

class BaseTestCase: XCTestCase {
    var dataController: DataController!
    var managedObjectContext: NSManagedObjectContext!

    override func setUpWithError() throws {
        dataController = DataController(inMemory: true)
        managedObjectContext = dataController.container.viewContext
    }
}
