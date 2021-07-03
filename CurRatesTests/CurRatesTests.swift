//
//  CurRatesTests.swift
//  CurRatesTests
//
//  Created by Maksim Kalik on 3/29/21.
//

import XCTest
import CurRatesNetwork
@testable import CurRates

class CurRatesTests: XCTestCase {

    private var currency: Currency = Currency.aud
    private var currenciesViewModel: CurrenciesViewModel = CurrenciesViewModel()
    
    func testEuroPriceForTransferBuy() {
        let result = currency.price(.transfer, .buy)
        XCTAssertEqual(result, "1.592")
    }
    
    func testEuroPriceForTransferSell() {
        let result = currency.price(.transfer, .sell)
        XCTAssertEqual(result, "1.514")
    }
    
    func testEuroPriceForRateBuy() {
        let result = currency.price(.rate, .buy)
        XCTAssertEqual(result, "1.600")
    }
    
    func testEuroPriceForRateSell() {
        let result = currency.price(.rate, .sell)
        XCTAssertEqual(result, "1.501")
    }
    
    func testUsdPriceForTransferBuy() {
        let result = currency.price(.transfer, .buy, unit: .USD)
        if currency.reverseUsdQuot {
            XCTAssertEqual(result, "1.281")
        } else {
            XCTAssertEqual(result, "0.781")
        }
    }
    
    func testUsdPriceForTransferSell() {
        let result = currency.price(.transfer, .sell, unit: .USD)
        if currency.reverseUsdQuot {
            XCTAssertEqual(result, "1.347")
        } else {
            XCTAssertEqual(result, "0.743")
        }
    }
    
    func testUsdPriceForRateBuy() {
        let result = currency.price(.rate, .buy, unit: .USD)
        if currency.reverseUsdQuot {
            XCTAssertEqual(result, "1.266")
        } else {
            XCTAssertEqual(result, "0.790")
        }
    }
    
    func testUsdPriceForRateSell() {
        let result = currency.price(.rate, .sell, unit: .USD)
        if currency.reverseUsdQuot {
            XCTAssertEqual(result, "1.357")
        } else {
            XCTAssertEqual(result, "0.737")
        }
        
    }

    func testMakeSureThatDefaultSelectedUnitIsEuro() {
        XCTAssertEqual(currency.unit, .EUR)
    }
    
    func testUnitUpdatingInCurrency() {
        currency.updateCurrencyUnit(unit: .USD)
        XCTAssertEqual(currency.unit, .USD)
    }
    
    func testCurrentDateRepresentation() {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM d"
        let result = currenciesViewModel.getCurrentDate()
        XCTAssertNotNil(dateFormatter.date(from: result))
    }
}
