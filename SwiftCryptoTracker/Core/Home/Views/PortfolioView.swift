//
//  PortfolioView.swift
//  SwiftCryptoTracker
//
//  Created by Peter Delgado on 7/9/22.
//

import SwiftUI

struct PortfolioView: View {

	@Environment(\.presentationMode) var presentationMode

	@EnvironmentObject private var vm: HomeViewModel
	@State private var selectedCoin: CoinModel? = nil
	@State private var quantityText: String = ""
	@State private var showCheckmark: Bool = false

	var body: some View {
		NavigationView{
			ScrollView{
				VStack(alignment: .leading, spacing:0){
					SearchBarView(searchText: $vm.searchText)
					coinLogoList

					if selectedCoin != nil {
						VStack(spacing: 20){
							HStack{
								Text("Current price of\(selectedCoin?.symbol.uppercased() ?? ""):")
								Spacer()
								Text(selectedCoin?.currentPrice.asCurrencyWith2Decimals() ?? "")
							}
							Divider()
							HStack{
								Text("Amount in your portfolio")
								Spacer()
								TextField("Ex: 1.4", text: $quantityText)
									.multilineTextAlignment(.trailing)
									.keyboardType(.decimalPad)
							}
							HStack{
								Text("Current Value:")
								Spacer()

								Text(getCurrentValue().asCurrencyWith2Decimals())
							}
						}
						.animation(.none)
						.padding()
						.font(.headline)
					}
				}

			}
			.navigationTitle("Edit Portfolio")
			.navigationBarItems(leading: Button(action: {
				presentationMode.wrappedValue.dismiss()
			}, label: {
				Image(systemName: "xmark")
					.font(.headline)
			}))
		}
	}
}

struct PortfolioView_Previews: PreviewProvider {
    static var previews: some View {
        PortfolioView()
			.environmentObject(dev.homeVM)
    }
}


extension PortfolioView {

	private var trailingNavBarButtons: some View{
		HStack(spacing: 10){
			Image(systemName: "checkmark")
				.opacity(showCheckmark ? 1.0 : 1.0)

			Button(action: {

			}, label: {
				Text("Save")
			})
			.opacity(
				(selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ? 1.0 : 0.0)
		}
	}

	private func saveButtonpressed(){

		guard let coin = selectedCoin else {return}
		//save to portfolio
		//show checkmark
		withAnimation(.easeIn){
			showCheckmark = true
		}
	}

	private var coinLogoList: some View{
		ScrollView(.horizontal, showsIndicators: false, content:{

			LazyHStack(spacing: 10){
				ForEach(vm.VMallCoins){ coin in
					CoinLogoView(coin: coin)
						.frame(width: 75)
						.padding(4)
						.onTapGesture {
							withAnimation(.easeIn){
								selectedCoin = coin
							}
						}
						.background(
							RoundedRectangle(cornerRadius : 10)
								.stroke(selectedCoin?.id == coin.id ? Color.theme.green : Color.clear, lineWidth: 1))
				}
			}
			.padding(.vertical, 4)
			.padding(.leading)

		})
	}

	private func getCurrentValue() -> Double {
		if let quantity = Double(quantityText){
			return quantity * (selectedCoin?.currentPrice ?? 0)
		}
		return 0
	}
}
