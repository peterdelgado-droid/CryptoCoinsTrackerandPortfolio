//
//  SwiftCryptoTrackerTests.swift
//  SwiftCryptoTrackerTests
//
//  Created by Peter Delgado on 20/9/23.
//

import XCTest
@testable import SwiftCryptoTracker

final class CoinDataServiceTests: XCTestCase {

	var coinDataService: CoinDataService!

	override func setUp() {
		super.setUp()
		coinDataService = CoinDataService()
	}

	override func tearDown() {
		coinDataService = nil
		super.tearDown()
	}

    func testExample() throws {
		func testGetCoins() {
			// Given
			let expectation = XCTestExpectation(description: "Fetch coins expectation")

			// When
			coinDataService.getCoins()

			// Then
			DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
				// Check if coins are fetched successfully
				XCTAssertFalse(self.coinDataService.allCoins.isEmpty, "Coins not fetched successfully")

				// Fulfill the expectation
				expectation.fulfill()
			}

			// Wait for the expectation to be fulfilled
			wait(for: [expectation], timeout: 10)
		}
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
			coinDataService.getCoins()
        }
    }

}
