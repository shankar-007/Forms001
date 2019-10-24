//
//  SampleTests.swift
//  SampleTests
//
//  Created by Mac HD on 24/10/19.
//  Copyright © 2019 HMSPL. All rights reserved.
//

import XCTest

@testable import SampleTest

class SampleTests: XCTestCase {
    
    var trackInfoVc: TrackerInfoViewController!

    override func setUp() {
        super.setUp()
        
        let stryBoard = UIStoryboard(name: "Main", bundle: nil)
        
        trackInfoVc = stryBoard.instantiateViewController(withIdentifier: "TrackerInfoViewControllerID") as? TrackerInfoViewController
    }

    override func tearDown() {
        super.tearDown()
        trackInfoVc = nil
    }

    func testExample() {
        
        let isValidInput = trackInfoVc.validateInputFields(fName: "vignesh", lName: "Ravichandran", email: "vickynesh210@gmail.com")
        
        XCTAssertTrue(isValidInput)
        
    }
    
    func emailTest() {
        XCTAssertTrue(trackInfoVc.isValidEmail(emailStr: "vg"))
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
