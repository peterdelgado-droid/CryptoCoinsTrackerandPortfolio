//
//  CoinImageService.swift
//  SwiftCryptoTracker
//
//  Created by Peter Delgado on 3/8/22.
//

import Foundation
import Combine
import SwiftUI

class CoinImageService{

	@Published var image: UIImage? = nil

	private var imageSubscription: AnyCancellable?
	private var coin: CoinModel


	init(coin: CoinModel){
		self.coin = coin
		getCoinImage()
 }


	private func getCoinImage(){
		print("downloading image now")
		guard let url = URL(string: coin.image)
		else {return}

		imageSubscription = NetworkManager.download(url: url)
			.tryMap({ (data) -> UIImage? in
				return UIImage(data: data)
			})
			.sink(receiveCompletion:  NetworkManager.handleCompletion, receiveValue: { [weak self] (returnedImage) in
				self?.image = returnedImage
				self?.imageSubscription?.cancel()
			})




	}





}
