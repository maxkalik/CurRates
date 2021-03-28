//
//  CurRatesTests.swift
//  CurRatesTests
//
//  Created by Maksim Kalik on 3/29/21.
//

import XCTest
@testable import CurRates

class CurRatesTests: XCTestCase {

    private var currency: Currency = Currency.aud
    
    func testEuroPriceForTransferBuy() throws {
        let result = currency.price(.transfer, .buy)
        XCTAssertEqual(result, "1.592")
    }
    
    func testEuroPriceForTransferSell() throws {
        let result = currency.price(.transfer, .sell)
        XCTAssertEqual(result, "1.514")
    }
    
    func testEuroPriceForRateBuy() throws {
        let result = currency.price(.rate, .buy)
        XCTAssertEqual(result, "1.600")
    }
    
    func testEuroPriceForRateSell() throws {
        let result = currency.price(.rate, .sell)
        XCTAssertEqual(result, "1.501")
    }

}
