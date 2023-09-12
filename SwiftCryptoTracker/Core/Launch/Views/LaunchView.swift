//
//  LaunchView.swift
//  SwiftCryptoTracker
//
//  Created by Peter Delgado on 12/9/23.
//

import SwiftUI

struct LaunchView: View {
	@State private var loadingText: [String] = "Loading Your Portofolio...".map{ String($0) }
	@State private var ShowloadingText: Bool = false
	let timer = Timer.publish(every: 0.1,on: .main,in: .common).autoconnect()
	@State private var counter: Int = 5

    var body: some View {
		ZStack {
			Color.Launchtheme.background
				.ignoresSafeArea()
			Image("logo-transparent")
				.resizable()
				.frame(width:100 ,height:100)

			ZStack {
				if ShowloadingText{
					HStack(spacing:0){
						ForEach(loadingText.indices){ index in
							Text(loadingText[index])
								.font(.headline)
								.fontWeight(.heavy)
								.foregroundColor(Color.Launchtheme.accent)
								.offset(y: counter == index ? -5 : 0)
						}
					}
					.transition(AnyTransition.scale.animation(.easeIn))
				}

			}
			.offset(y: 70)
		}
		.onAppear{
			ShowloadingText.toggle()
		}
		.onReceive(timer, perform: { _ in
			withAnimation(.spring()){
				let lastIndex = loadingText.count - 1
				if counter == lastIndex{
					counter = 0
				} else{
					counter += 1
				}


			}
		})

    }
}

struct LaunchView_Previews: PreviewProvider {
    static var previews: some View {
        LaunchView()
    }
}
