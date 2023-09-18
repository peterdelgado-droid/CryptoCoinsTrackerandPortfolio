//
//  DetailViewModel.swift
//  SwiftCryptoTracker
//
//  Created by Peter Delgado on 14/9/23.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
	
	@Published var overviewStatistics: [StatisticModel] = []
	@Published var additionalStatistics: [StatisticModel] = []
	
	@Published var coin: CoinModel
	private let coinDetailService: CoinDetailService
	private var cancellables = Set<AnyCancellable>()
	
	init(coin: CoinModel){
		self.coin = coin
		self.coinDetailService = CoinDetailService(coin: coin)
		addSubscribers()
		
	}
	
	private func addSubscribers(){
		
		coinDetailService.$coinDetails
			.combineLatest($coin)
			.map({ (CoinDetailModel, coinModel) -> (overview: [StatisticModel], additional: [StatisticModel]) in
				
				//overview
				let price = coinModel.currentPrice.asCurrencyWith6Decimals()
				let priceChange = coinModel.priceChangePercentage24HInCurrency
				let priceStat = StatisticModel(title: "Current Price", value: price, percentageChange: priceChange)
				
				let marketCap = "$" + (coinModel.marketCap?.formattedWithAbbreviations() ?? "")
				let marketCapChange = coinModel.marketCapChangePercentage24H
				let marketCapStat = StatisticModel(title: "Market Captilaztion", value: marketCap, percentageChange: marketCapChange)
				
				let rank = "\(coinModel.rank)"
				let rankSet = StatisticModel(title: "Rank", value: rank)
				
				let volume = "$" + (coinModel.totalVolume?.formattedWithAbbreviations() ?? "")
				let volumSet = StatisticModel(title: "Volume", value: volume)
				
				let overviewArray: [StatisticModel] = [
					priceStat, marketCapStat, rankSet, volumSet
				]
				
				//additional
				
				let high = coinModel.high24H?.asCurrencyWith6Decimals() ?? "n/a"
				let highStat = StatisticModel(title: "24h High", value: high)
				
				let low = coinModel.low24H?.asCurrencyWith6Decimals() ?? "n/a"
				let lowStat = StatisticModel(title: "24h Low", value: low)
				
				let priceChangeSecond = coinModel.priceChangePercentage24H?.asCurrencyWith6Decimals() ?? "n/a"
				let pricepercentChange = coinModel.priceChangePercentage24HInCurrency
				let priceStatSecond = StatisticModel(title: "24h Price Change", value: priceChangeSecond, percentageChange: pricepercentChange)
				
				let marketCapChangeSecond = "$" + (coinModel.marketCapChange24H?.formattedWithAbbreviations() ?? "")
				let marketpricepercentChange = coinModel.marketCapChange24H
				let marketpriceStat = StatisticModel(title: "24h Market Cap Change", value: marketCapChangeSecond, percentageChange: marketpricepercentChange)
				
				let blockTime = CoinDetailModel?.blockTimeInMinutes ?? 0
				let blockTimeString = blockTime == 0 ? "n/a": "\(blockTime)"
				let blockStat = StatisticModel(title: "Block Time", value: blockTimeString)
				
				let hashing = CoinDetailModel?.hashingAlgorithm ?? "n/a"
				let hashingStat = StatisticModel(title: "Hashing Algorithm", value: hashing)
				
				let additionalArray: [StatisticModel] = [
					highStat, lowStat, priceStatSecond, marketpriceStat, blockStat, hashingStat
				]
				
				return (overviewArray, additionalArray)
			})
			.sink {[weak self] (returnedCoinDetails) in
				print("Recieved Coin Detail")
				self?.overviewStatistics = returnedCoinDetails.overview
				self?.additionalStatistics = returnedCoinDetails.additional
				
			}
			.store(in: &cancellables)
		
		
	}
}
