//
//  TransactionModelTest.swift
//  ProductsGNBTests
//
//  Created by Fran Cazorla on 3/2/23.
//

import XCTest
import Foundation
@testable import ProductsGNB

final class TransactionModelTest: XCTestCase {
    
    let conversions: [RateModel] = [RateModel(from: "EUR", to: "USD", rate: 1.04),RateModel(from: "USD", to: "EUR", rate: 0.96),RateModel(from: "GBP", to: "EUR", rate: 1.16),RateModel(from: "JPY", to: "USD", rate: 0.0073),RateModel(from: "AUD", to: "INR", rate: 55.29),RateModel(from: "CAD", to: "USD", rate: 0.74),RateModel(from: "SEK", to: "USD", rate: 0.096),RateModel(from: "RUB", to: "SEK", rate: 0.17), RateModel(from: "INR", to: "EUR", rate: 0.012)]

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    
    func testconvertToEurosOneConversion(){
        let transaction = TransactionModel(sku: "T1234", amount: 1000.0, currency: "USD")

        let result = transaction.convertToEuros(amount: transaction.amount, currency: transaction.currency, conversions: self.conversions)
        
        XCTAssertEqual(result, 960)
    }
    
    func testconvertToEurosTwoConversion(){
        let transaction = TransactionModel(sku: "T1234", amount: 1000.0, currency: "SEK")

        let result = transaction.convertToEuros(amount: transaction.amount, currency: transaction.currency, conversions: self.conversions)
        
        XCTAssertEqual(result, 92.16)

    }
    
    func testconvertToEurosTreeConversion(){
        let transaction = TransactionModel(sku: "T1234", amount: 1000.0, currency: "RUB")

        let result = transaction.convertToEuros(amount: transaction.amount, currency: transaction.currency, conversions: self.conversions)
        
        XCTAssertEqual(result, 15.67)

    }
    
    

}
