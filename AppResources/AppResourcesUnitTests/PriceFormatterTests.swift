//
//  AppResourcesUnitTests.swift
//  AppResourcesUnitTests
//
//  Created by Fahreddin Hepdonduran on 21.12.2023.
//

import XCTest
@testable import AppResources

final class AppResourcesUnitTests: XCTestCase {

    var sut = PriceFormatter()
    
    override func setUpWithError() throws {
        try super.setUpWithError()
    }

    override func tearDownWithError() throws {
        try super.tearDownWithError()
    }

    func test_FormatWithoutDecimalPlace() throws {
        let given = 1500
        
        let calculated = sut.format(price: given)
        
        XCTAssertEqual(calculated, "1.500")
    }
    
    func test_FormatThreeDigitsSuccessfuly() throws {
        let given = 500
        
        let calculated = sut.format(price: given)
        
        XCTAssertEqual(calculated, "500")
    }
    
    func test_FormatTwoDigitsSuccessfuly() throws {
        let given = 50
        
        let calculated = sut.format(price: given)
        
        XCTAssertEqual(calculated, "50")
    }
    
    func test_FormatOneDigitsSuccessfuly() throws {
        let given = 5
        
        let calculated = sut.format(price: given)
        
        XCTAssertEqual(calculated, "5")
    }
    
    func test_FormatZeroSuccessfuly() throws {
        let given = 0
        
        let calculated = sut.format(price: given)
        
        XCTAssertEqual(calculated, "0")
    }

}
