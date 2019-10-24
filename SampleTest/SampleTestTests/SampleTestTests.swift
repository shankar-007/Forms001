//
//  SampleTestTests.swift
//  SampleTestTests
//
//  Created by Mac HD on 24/10/19.
//  Copyright © 2019 HMSPL. All rights reserved.
//

import XCTest
@testable import SampleTest

class SampleTestTests: XCTestCase {
    
    var trackInfoViewController: TrackerInfoViewController!

    override func setUp() {
        super.setUp()
        let story = UIStoryboard(name: "Main", bundle: nil)
        
        trackInfoViewController = story.instantiateViewController(withIdentifier: "TrackerInfoViewControllerID") as? TrackerInfoViewController
    }

    override func tearDown() {
        trackInfoViewController = nil
        super.tearDown()
    }

    func testExample() {
        let isValid = trackInfoViewController.validateInputFields(fName: "Vi", lName: "Ravichandran", email: "vickynesh210@gmail.com")
        
        XCTAssertTrue(isValid)
    }
    
    func emailTest()  {
        XCTAssertTrue(trackInfoViewController.isValidEmail(emailStr: "vig@"))
        
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
