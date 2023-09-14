//
//  DetailView.swift
//  SwiftCryptoTracker
//
//  Created by Peter Delgado on 14/9/23.
//

import SwiftUI

struct DetailView: View {

	let coin: CoinModel
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
		DetailView(coin: dev.coin)
    }
}
