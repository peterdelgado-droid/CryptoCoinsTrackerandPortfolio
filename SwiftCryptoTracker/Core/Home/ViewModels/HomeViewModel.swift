//
//  HomeViewModel.swift
//  SwiftCryptoTracker
//
//  Created by Peter Delgado on 3/8/22.
//

import Foundation
import Combine


class HomeViewModel: ObservableObject {

	@Published var statistics: [StatisticModel] = []
	//view model allCoins
	@Published var VMallCoins: [CoinModel] = []
	@Published var portfolioCoins: [CoinModel] = []
	@Published var searchText: String = ""

	private let dataService = CoinDataService()
	private let marKetdataService = MarketDataService()
	private var cancellables = Set<AnyCancellable>()
	private let portfolioDataService = PortfolioDataService()





	init(){
		addSubsribers()
		
	}



	func addSubsribers(){
		//updates marketData
		marKetdataService.$marketData
			.map { (marketDataModel) -> [StatisticModel] in
				var stats: [StatisticModel] = []

				guard let data = marketDataModel else {
					return stats
				}
				let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange:data.marketCapChangePercentage24HUsd)
				let volume = StatisticModel(title: "24h Volume", value: data.volume, percentageChange: 5 )
				let btcDominance = StatisticModel(title: "BTC Dominance", value: data.btcDominance, percentageChange: 8)
				let portfolio = StatisticModel(title: "Portfolio Value", value: "$0.00", percentageChange:0 )
				stats.append(contentsOf:[
					marketCap,
					volume,
					btcDominance,
					portfolio

				])
				return stats
			}
			.sink { [weak self] (returnedStats) in
				self?.statistics = returnedStats
			}
			.store(in: &cancellables)
		dataService.$allCoins
			.sink { [weak self] (returnedCoins) in
				self?.VMallCoins = returnedCoins
			}
			.store(in: &cancellables)
		//updates portfolioCoins when searching
		$searchText.combineLatest(dataService.$allCoins)
			.map{ (text, startingCoins) -> [CoinModel] in
				
				guard !text.isEmpty else{
					return startingCoins
				}
				let lowerCase = text.lowercased()
				return startingCoins.filter { (coin) -> Bool in
					return coin.name.lowercased().contains(lowerCase) ||
					coin.symbol.lowercased().contains(lowerCase) ||
					coin.id.lowercased().contains(lowerCase)
				}

			}
			.sink { [weak self] (returnedCoins) in
				self?.VMallCoins = returnedCoins
			}
			.store(in: &cancellables)

		//update database portfolio coins
		$VMallCoins
			.combineLatest(portfolioDataService.$savedEntities)
			.map { (coinModels, portfolioEntities) -> [CoinModel] in
				coinModels
					.compactMap{ (coin) -> CoinModel? in
						guard let entity = portfolioEntities.first(where: {$0.coinID == coin.id }) else {
							return nil
						}
						return coin.updateHoldings(amount: entity.amount)

					}
			}
			.sink{ [weak self] (returnedCoins) in
				self?.portfolioCoins = returnedCoins
			}
			.store(in: &cancellables)

	}

	func updatePortfolio(coin: CoinModel, amount: Double){
		portfolioDataService.updatePortfolio(coin: coin, amount: amount)
	}


	func backwardsPrime(start: Int, end: Int) -> [Int] {
		var result: [Int] = []

		func isPrime(_ number: Int) -> Bool {
			if number < 2 {
				return false
			}

			for i in 2..<Int(sqrt(Double(number))) + 1 {
				if number % i == 0 {
					return false
				}
			}

			return true
		}

		for num in start...end {
			let reversedNum = Int(String(String(num).reversed()))!

			if num != reversedNum && isPrime(num) && isPrime(reversedNum) {
				result.append(num)
			}
		}

		return result
	}



	// Example usage:






	}
