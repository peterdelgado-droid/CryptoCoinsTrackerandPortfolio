//
//  SettingsView.swift
//  SwiftCryptoTracker
//
//  Created by Peter Delgado on 20/9/23.
//

import SwiftUI

struct SettingsView: View {

	let coingeckoURL = URL(string: "https://www.coingecko.com")!
	var body: some View {

			List {
				XMarkButton()
			Section(header: Text("Info")) {
				coinGeckoSection
				}

			}
			.font(.headline)
			.accentColor(.blue)
			.listStyle(GroupedListStyle())
			.navigationTitle("Info")
			.toolbar{
				ToolbarItem(placement: .navigationBarTrailing) {
					XMarkButton()
				}


			}


    }
}

extension SettingsView {

	private var coinGeckoSection: some View{
		Section(header: Text("CoinGecko")) {
			VStack(alignment: .leading) {
				Image("coingecko")
					.resizable()
					.scaledToFit()
					.frame(height: 100)
					.clipShape(RoundedRectangle(cornerRadius: 20))
				Text("The cryptocurrency data that is used in this app come from a free API from CoinGecko. Price may be slightly delayed.")
			}
			.padding(.vertical)
			Link("Visit CoinGecko", destination: coingeckoURL)
		}
	}

}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
