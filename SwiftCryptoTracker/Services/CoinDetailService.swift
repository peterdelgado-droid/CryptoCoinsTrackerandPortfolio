//
//  CoinDetailService.swift
//  SwiftCryptoTracker
//
//  Created by Peter Delgado on 14/9/23.
//

import Foundation
import Combine

class CoinDetailService{

	@Published var coinDetails: [CoinDetailModel?] = []
	var coinDetailSubscription: AnyCancellable?
	let coin: CoinModel

	init(coin: CoinModel){
		self.coin = coin
		getCoinDetails()
	}

	private func getCoinDetails(){
		guard let url = URL(string:"https://api.coingecko.com/api/v3/coins/\(coin.id)?localization=false&tickers=false&market_data=false&community_data=false&developer_data=false&sparkline=false")
		else {return}

		coinDetailSubscription = NetworkManager.download(url: url)
			.decode(type: [CoinDetailModel].self, decoder: JSONDecoder())
			.sink(receiveCompletion:  NetworkManager.handleCompletion, receiveValue: { [weak self] (returnedCoinDetails) in
				self?.coinDetails = returnedCoinDetails
				self?.coinDetailSubscription?.cancel()
			})
	}
}
