//
//  HomeViewModel.swift
//  SwiftCryptoTracker
//
//  Created by Peter Delgado on 3/8/22.
//

import Foundation
import Combine

//StatisticModel(title: "Title", value: "Value", percentageChange: 1),
//StatisticModel(title: "Title", value: "Value"),
//StatisticModel(title: "Title", value: "Value"),
//StatisticModel(title: "Title", value: "Value", percentageChange: -7),

class HomeViewModel: ObservableObject {

	@Published var statistics: [StatisticModel] = []

   //view model allCoins
	@Published var VMallCoins: [CoinModel] = []
	@Published var portfolioCoins: [CoinModel] = []


	@Published var searchText: String = ""

	private let dataService = CoinDataService()
	private let marKetdataService = MarketDataService()
	private var cancellables = Set<AnyCancellable>()

	init(){
		addSubsribers()
	}


	func addSubsribers(){
		marKetdataService.$marketData
			.map { (marketDataModel) -> [StatisticModel] in
				var stats: [StatisticModel] = []

				guard let data = marketDataModel else {
					return stats

				}

				let marketCap = StatisticModel(title: "Market Cap", value: data.marketCap, percentageChange:
												data.marketCapChangePercentage24HUsd)
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
	}

}
