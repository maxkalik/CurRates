//
//  CurRatesUITests.swift
//  CurRatesUITests
//
//  Created by Maksim Kalik on 3/29/21.
//

import XCTest

class CurRatesUITests: XCTestCase {
    
    let app = XCUIApplication()
    
    func testDefaultSelectedButtonInSegmentControl() {
        let segmentControl = app.navigationBars.segmentedControls
        app.launch()
        let eurButton = segmentControl.buttons["€"]
        XCTAssert(eurButton.isSelected)
    }
    
    func testChaningValueInSegmentControl() {
        app.launch()
        let segmentControl = app.navigationBars.segmentedControls
        let eurButton = segmentControl.buttons["€"]
        let usdButton = segmentControl.buttons["$"]
        
        if eurButton.isSelected {
            usdButton.tap()
            XCTAssert(usdButton.isSelected)
        } else {
            eurButton.tap()
            XCTAssert(eurButton.isSelected)
        }
    }
    
    func testValueChanged() {
        app.launch()
        app.tables.staticTexts["AUD"].tap()
        XCTAssert(app.navigationBars.buttons["Currencies"].exists)
    }
    
}
