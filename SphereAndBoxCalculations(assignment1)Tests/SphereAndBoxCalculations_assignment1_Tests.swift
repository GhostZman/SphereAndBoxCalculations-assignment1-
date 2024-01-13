//
//  SphereAndBoxCalculations_assignment1_Tests.swift
//  SphereAndBoxCalculations(assignment1)Tests
//
//  Created by Phys440Zachary on 1/12/24.
//

import XCTest

class SphereAndBoxCalculations_assignment1_Tests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testBoxVolume() async {
        let myBox = Box()
        
        let x = 20.0
        let y = 1.0
        let z = 5.0
        
        let area = await myBox.calculateVolume(x: x, y: y, z: z)
        
        XCTAssertEqual(area.Value, 100.0, accuracy:1.0E-7, "Was not equal to this resolution.")
        
    }
    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        // Any test you write for XCTest can be annotated as throws and async.
        // Mark your test throws to produce an unexpected failure when your test encounters an uncaught error.
        // Mark your test async to allow awaiting for asynchronous code to complete. Check the results with assertions afterwards.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
