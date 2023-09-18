//
//  DetailView.swift
//  SwiftCryptoTracker
//
//  Created by Peter Delgado on 14/9/23.
//

import SwiftUI


struct DetailLoadingView: View{
	@Binding var coin: CoinModel?

	var body: some View {
		ZStack{
			if let coin = coin{
				DetailView(coin: coin)
			}
		}

	}

}

struct DetailView: View {

	@StateObject var vm: DetailViewModel
	private let columns: [GridItem] = [
		GridItem(.flexible()),
		GridItem(.flexible())
	]
	private let spacing: CGFloat = 30

	@Environment(\.presentationMode) var presentationMode
	
	
	init(coin: CoinModel) {
		_vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
		print("Initializing Detail View for\(coin.name)")
	}
	var body: some View {
		NavigationView{

			ScrollView{

				VStack(spacing: 20){
					//Color.Launchtheme.background
					Text("\(vm.coin.name)")
						.frame(height: 150)
						.foregroundColor(Color.Launchtheme.accent)

					Text("Overview")
						.font(.title)
						.bold()
						.foregroundColor(Color.Launchtheme.accent)
						.frame(maxWidth: .infinity, alignment: .leading)
					navigationBarTrailingItems
					Divider()


					LazyVGrid(
						columns: columns,
						alignment: .center,
						spacing: spacing,
						pinnedViews: [],
						content:{
							ForEach(vm.overviewStatistics) { stat in
								StatisticView(stat:stat)
							}
						})

					Text("Additional Details")
						.font(.title)
						.bold()
						.foregroundColor(Color.Launchtheme.accent)
						.frame(maxWidth: .infinity, alignment: .leading)
					Divider()

					LazyVGrid(
						columns: columns,
						alignment: .center,
						spacing: spacing,
						pinnedViews: [],
						content:{
							ForEach(vm.additionalStatistics) { stat in
								StatisticView(stat: stat)
							}
						})
				}
				.padding()
			}.background(Color.Launchtheme.background)
				.navigationTitle(vm.coin.name)
				.navigationBarItems(leading: Button(action: {
					presentationMode.wrappedValue.dismiss()
				}, label: {
					Image(systemName: "xmark")
						.font(.headline)
						.foregroundColor(Color.Launchtheme.accent)
				}))
			}
	}
}

extension DetailView{

	private var navigationBarTrailingItems: some View{

		HStack{
			Text(vm.coin.symbol.uppercased())
				.font(.headline)
				.foregroundColor(Color.theme.secondaryText)
			CoinImageView(coin: vm.coin)
				.frame(width: 25, height: 25)
		}
	}


}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationView{
			DetailView(coin: dev.coin)
		}
    }
}
