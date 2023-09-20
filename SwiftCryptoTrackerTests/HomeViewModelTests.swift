//
//  HomeViewModelTests.swift
//  SwiftCryptoTrackerTests
//
//  Created by Peter Delgado on 20/9/23.
//

import XCTest
@testable import SwiftCryptoTracker

final class HomeViewModelTests: XCTestCase {
	var homeViewModel: HomeViewModel!

	override func setUp() {
		super.setUp()
		homeViewModel = HomeViewModel()
	}

	override func tearDown() {
		homeViewModel = nil
		super.tearDown()
	}

	func testAddSubscribers() {
		// Given
		let expectation = XCTestExpectation(description: "Add subscribers expectation")

		// When
		homeViewModel.addSubsribers()

		// Then
		DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
			// Check if statistics are fetched successfully
			XCTAssertFalse(self.homeViewModel.statistics.isEmpty, "Statistics not fetched successfully")

			// Check if VMallCoins are fetched successfully
			XCTAssertFalse(self.homeViewModel.VMallCoins.isEmpty, "VMallCoins not fetched successfully")

			// Check if portfolioCoins are fetched successfully
			XCTAssertFalse(self.homeViewModel.portfolioCoins.isEmpty, "PortfolioCoins not fetched successfully")

			// Fulfill the expectation
			expectation.fulfill()
		}

		// Wait for the expectation to be fulfilled
		wait(for: [expectation], timeout: 10)
	}


}
