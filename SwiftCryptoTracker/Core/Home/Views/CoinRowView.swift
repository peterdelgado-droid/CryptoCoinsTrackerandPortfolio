//
//  CoinRowView.swift
//  SwiftCryptoTracker
//
//  Created by Peter Delgado on 2/8/22.
//

import SwiftUI

struct CoinRowView: View {
	let coin: CoinModel
	let showHoldingColumn : Bool

	var body: some View {
		HStack(spacing: 0){
			leftColumn
			Spacer()
			if showHoldingColumn {
				centerColumn

			}
			rightColumn
		}
		.font(.subheadline)
    }

}

struct CoinRowView_Previews: PreviewProvider {
    static var previews: some View {
		Group{
			CoinRowView(coin: dev.coin, showHoldingColumn: true )
				.previewLayout(.sizeThatFits)

			CoinRowView(coin: dev.coin, showHoldingColumn: true )
				.previewLayout(.sizeThatFits)
				.preferredColorScheme(.dark)
		}
    }
}

extension CoinRowView {
	private var leftColumn: some View{

		HStack (spacing: 0){
			Text("\(coin.rank)")
				.font(.caption)
				.foregroundColor(Color.Launchtheme.accent)
				.frame(minWidth: 30)
			CoinImageView(coin:coin)
				.frame(width: 30, height: 30)
			Text(coin.symbol.uppercased())
				.font(.headline)
				.padding(.leading, 6)
				.foregroundColor(Color.Launchtheme.accent)
		}
	}

	private var centerColumn: some View{

		VStack(alignment: .trailing){
			Text(coin.currentHoldingsValue.asCurrencyWith2Decimals())
				.bold()
			Text((coin.currentHoldings ?? 0).asNumberString()).foregroundColor(Color.Launchtheme.accent)
		}
	}

//this needs to be optimized
	private var rightColumn: some View{

		VStack{
			Text("\(coin.currentPrice.asCurrencyWith6Decimals())").foregroundColor(Color.Launchtheme.accent)
			Text(coin.priceChangePercentage24H?.asPercentString() ?? "")
				.foregroundColor((coin.priceChangePercentage24H ?? 0) >= 0 ? Color.theme.green :
									Color.theme.red)
		}
		.frame(width: UIScreen.main.bounds.width / 3.5, alignment: .trailing)
		}
	}
