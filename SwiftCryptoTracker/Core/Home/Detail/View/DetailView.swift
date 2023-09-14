//
//  DetailView.swift
//  SwiftCryptoTracker
//
//  Created by Peter Delgado on 14/9/23.
//

import SwiftUI

struct DetailView: View {

	@Binding var coin: CoinModel

	let coin: CoinModel
	init(coin: Binding<CoinModel>) {
		self_.coin = coin
		print("Initializing Detail Veiw for")
	}
    var body: some View {
		Text(coin.name)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
		DetailView(coin: .constant(dev.coin))
    }
}
