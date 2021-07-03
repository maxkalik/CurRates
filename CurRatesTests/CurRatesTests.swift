//
//  CurRatesTests.swift
//  CurRatesTests
//
//  Created by Maksim Kalik on 3/29/21.
//

import XCTest
@testable import CurRates

class CurRatesTests: XCTestCase {

    private var currency: Currency = Currency.gbr
    private var currenciesViewModel: CurrenciesViewModel = CurrenciesViewModel()
    
    func roundedResult(_ value: String?, isReverseUsdQuote: Bool = false) -> String {
        guard let result = Float(value ?? "") else { return "" }
        if isReverseUsdQuote {
            return String(format: "%.3f", 1 / result)
        }
        return String(format: "%.3f", result)
    }
    
    func testEuroPriceForTransferBuy() {
        let result = currency.price(.transfer, .buy, unit: .EUR)
        let mock = roundedResult(currency.rates[0].buyTransfer)
        XCTAssertEqual(result, mock)
    }

    func testEuroPriceForTransferSell() {
        let result = currency.price(.transfer, .sell, unit: .EUR)
        let mock = roundedResult(currency.rates[0].sellTransfer)
        XCTAssertEqual(result, mock)
    }
    
    func testEuroPriceForRateBuy() {
        let result = currency.price(.rate, .buy, unit: .EUR)
        let mock = roundedResult(currency.rates[0].buyRate)
        XCTAssertEqual(result, mock)
    }
    
    func testEuroPriceForRateSell() {
        let result = currency.price(.rate, .sell, unit: .EUR)
        let mock = roundedResult(currency.rates[0].sellRate)
        XCTAssertEqual(result, mock)
    }
    
    func testUsdPriceForTransferBuy() {
        let result = currency.price(.transfer, .buy, unit: .USD)
        let mock = roundedResult(currency.rates[1].buyTransfer, isReverseUsdQuote: currency.reverseUsdQuot)
        XCTAssertEqual(result, mock)
    }
    
    func testUsdPriceForTransferSell() {
        let result = currency.price(.transfer, .sell, unit: .USD)
        let mock = roundedResult(currency.rates[1].sellTransfer, isReverseUsdQuote: currency.reverseUsdQuot)
        XCTAssertEqual(result, mock)
    }
    
    func testUsdPriceForRateBuy() {
        let result = currency.price(.rate, .buy, unit: .USD)
        let mock = roundedResult(currency.rates[1].buyRate, isReverseUsdQuote: currency.reverseUsdQuot)
        XCTAssertEqual(result, mock)
    }
    
    func testUsdPriceForRateSell() {
        let result = currency.price(.rate, .sell, unit: .USD)
        let mock = roundedResult(currency.rates[1].sellRate, isReverseUsdQuote: currency.reverseUsdQuot)
        XCTAssertEqual(result, mock)
        
    }

    func testMakeSureThatDefaultSelectedUnitIsEuro() {
        XCTAssertEqual(currency.unit, Configuration.currency)
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
