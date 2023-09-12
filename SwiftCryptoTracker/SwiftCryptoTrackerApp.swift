//
//  SwiftCryptoTrackerApp.swift
//  SwiftCryptoTracker
//
//  Created by Peter Delgado on 2/8/22.
//

import SwiftUI

@main
struct SwiftCryptoTrackerApp: App {

  @StateObject private var vm = HomeViewModel()
	var body: some Scene {
        WindowGroup {
			NavigationView{
				HomeView()
					//.hidden()
			}
		.environmentObject(vm)
        }
    }
}
