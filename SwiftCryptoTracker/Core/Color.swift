//
//  Color.swift
//  SwiftCryptoTracker
//
//  Created by Peter Delgado on 2/8/22.
//

import Foundation
import SwiftUI

extension Color {
	static let theme = ColorTheme()
	static let Launchtheme = LaunchTheme()
}

struct ColorTheme {

	let accent = Color("AccentColor")
	let background = Color("BackgroundColor")
	let green = Color("GreenColor")
	let red = Color("RedColor")
	let secondaryText = Color("SecondaryTextColor")
}

struct LaunchTheme {

	let accent = Color("LaunchAccentColor")
	let background = Color("LaunchBackgroundColor")
}
