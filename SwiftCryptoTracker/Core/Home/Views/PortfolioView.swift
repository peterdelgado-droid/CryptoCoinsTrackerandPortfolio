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
							}.foregroundColor(Color.Launchtheme.accent)
							HStack{
								Text("Current Value:")
									.foregroundColor(Color.Launchtheme.accent)
								Spacer()
								Text(getCurrentValue().asCurrencyWith2Decimals())

							}
						}
						.animation(.none)
						.padding()
						.font(.headline)
					}
				}.foregroundColor(Color.Launchtheme.accent)

			}.background(Color.Launchtheme.background)
			.navigationTitle("Edit Portfolio")
			.navigationBarItems(leading: Button(action: {
				presentationMode.wrappedValue.dismiss()
			}, label: {
				Image(systemName: "xmark")
					.font(.headline)
					.foregroundColor(Color.Launchtheme.accent)
			}))
			.toolbar(content: {
				ToolbarItem(placement: .navigationBarTrailing) {
					HStack(spacing: 10){
							Image(systemName: "checkmark")
							.foregroundColor(Color.Launchtheme.accent)
							.opacity(showCheckmark ? 1.0: 0.0)

						Button(action: {
							saveButtonpressed()
							}, label: {
						Text("Save".uppercased())
						.foregroundColor(Color.Launchtheme.accent)
						})
						.opacity(
							(selectedCoin != nil && selectedCoin?.currentHoldings != Double(quantityText)) ? 1.0 : 0.0
						)}
				}
			})
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

		guard
			let coin = selectedCoin,
			let amount = Double(quantityText)
		else { return }


		//save to portfolio
		vm.updatePortfolio(coin: coin, amount: amount)

		//show checkmark
		withAnimation(.easeIn){
			showCheckmark = true
			removeSelectedCoin()
		}

		//hide checkmark
		DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
			withAnimation(.easeOut){
				showCheckmark = false
			}
		}
	}

	private func removeSelectedCoin() {
		selectedCoin = nil
		vm.searchText = ""
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
