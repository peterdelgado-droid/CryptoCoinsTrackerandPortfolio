//
//  DetailViewModel.swift
//  SwiftCryptoTracker
//
//  Created by Peter Delgado on 14/9/23.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {

	private let coinDetailService: CoinDetailService
	private var cancellables = Set<AnyCancellable>()

	init(coin: CoinModel){
		self.coinDetailService = CoinDetailService(coin: coin)
		addSubscribers()

	}

	private func addSubscribers(){

		coinDetailService.$coinDetails
			.sink { (returnedCoinDetails) in
				print("Recieved Coin Detail")
				print(returnedCoinDetails)
			}
			.store(in: &cancellables)
	}



}
