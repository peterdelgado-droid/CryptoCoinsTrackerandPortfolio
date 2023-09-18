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

	let navBarAppeareance = UINavigationBarAppearance()

	init(){
		UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.Launchtheme.accent)]
		UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor(Color.Launchtheme.accent)]
		navBarAppeareance.backgroundColor = UIColor(Color.Launchtheme.background)

		
		UINavigationBar.appearance().scrollEdgeAppearance = navBarAppeareance
		UINavigationBar.appearance().standardAppearance = navBarAppeareance


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
