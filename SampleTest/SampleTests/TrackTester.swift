//
//  TrackTester.swift
//  SampleTests
//
//  Created by Mac HD on 24/10/19.
//  Copyright © 2019 HMSPL. All rights reserved.
//

import XCTest

@testable import SampleTest

class TrackTester: XCTestCase {
    
    var trackInfoVc: TrackerInfoViewController!
    
    override func setUp() {
        super.setUp()
        
        let stryBoard = UIStoryboard(name: "Main", bundle: nil)
        
        trackInfoVc = stryBoard.instantiateViewController(withIdentifier: "TrackerInfoViewControllerID") as? TrackerInfoViewController
        
        trackInfoVc.loadViewIfNeeded()
    }
    
    override func tearDown() {
        super.tearDown()
        trackInfoVc = nil
    }
    
    func testExample() {
        
        trackInfoVc.getUserLocation(lat: -26.2041028, long: 28.0473051)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 4) {
            XCTAssertEqual(self.trackInfoVc.lblLocation.text, "Johannesburg")
        }
        
    }
    
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
