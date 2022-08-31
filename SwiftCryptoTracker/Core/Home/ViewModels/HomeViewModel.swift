//
//  HomeViewModel.swift
//  SwiftCryptoTracker
//
//  Created by Peter Delgado on 3/8/22.
//

import Foundation
import Combine


class HomeViewModel: ObservableObject {

	@Published var allCoins: [CoinModel] = []
	@Published var portfolioCoins: [CoinModel] = []


	@Published var searchText: String = ""

	private let dataService = CoinDataService()
	private var cancellables = Set<AnyCancellable>()

	init(){

		addSubsribers()
}


	func addSubsribers(){
		dataService.$allCoins
			.sink { [weak self] (returnedCoins) in
				self?.allCoins = returnedCoins
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
				self?.allCoins = returnedCoins
			}
			.store(in: &cancellables)
	}

}
