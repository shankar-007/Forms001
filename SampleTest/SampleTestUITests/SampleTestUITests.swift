//
//  SampleTestUITests.swift
//  SampleTestUITests
//
//  Created by Mac HD on 24/10/19.
//  Copyright © 2019 HMSPL. All rights reserved.
//

import XCTest


class SampleTestUITests: XCTestCase {

    var xcApp: XCUIApplication!
    
    //var trackInfoVc: TrackerInfoViewController!
    
    override func setUp() {
        
        super.setUp()
        
        xcApp = XCUIApplication()
        
        continueAfterFailure = false
        
//        let stryBoard = UIStoryboard(name: "Main", bundle: nil)
//
//        trackInfoVc = stryBoard.instantiateViewController(withIdentifier: "TrackerInfoViewControllerID") as? TrackerInfoViewController
//
//        trackInfoVc.loadViewIfNeeded()
        
    }

    override func tearDown() {
        super.tearDown()
        
        xcApp = nil
        
       // trackInfoVc = nil
    }

    func testExample() {
        
    }
    
    func testingAlert() {
        xcApp.launch()
        
        xcApp.buttons["Submit"].tap()
        
        XCTAssertTrue(xcApp.alerts["Alert"].exists)
    }

}
