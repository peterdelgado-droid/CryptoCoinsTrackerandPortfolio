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
	
	
	init(coin: CoinModel) {
		_vm = StateObject(wrappedValue: DetailViewModel(coin: coin))
		print("Initializing Detail View for\(coin.name)")
	}
    var body: some View {
		ScrollView{
			VStack(spacing: 20){
				Text("hi")
					.frame(height: 150)

				Text("Overview")
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
		}
		.navigationTitle(vm.coin.name)
	}

}

struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationView{
			DetailView(coin: dev.coin)
		}
    }
}
