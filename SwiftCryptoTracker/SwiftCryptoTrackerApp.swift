//
//  SwiftCryptoTrackerApp.swift
//  SwiftCryptoTracker
//
//  Created by Peter Delgado on 2/8/22.
//

import SwiftUI

@main
struct SwiftCryptoTrackerApp: App {

  @State private var showLaunchView: Bool = true

	init(){
		UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.Launchtheme.accent)]
	}

  @StateObject private var vm = HomeViewModel()
	var body: some Scene {
        WindowGroup {
			ZStack{
				NavigationView{
					HomeView()
				}

				ZStack{
					if showLaunchView{
						LaunchView(showLaunchView: $showLaunchView)
							.transition(.move(edge: .leading))
					}

				}
				.zIndex(2.0)

			}

		.environmentObject(vm)
        }
    }
}
