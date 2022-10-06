//
//  LocalFileManager.swift
//  SwiftCryptoTracker
//
//  Created by Peter Delgado on 3/8/22.
//

import Foundation
import SwiftUI

class LocalFileManager{

	static let instance = LocalFileManager()
	private init(){}

	func saveImage(image: UIImage, imageName: String, folderName: String){
		guard let data = image.pngData(),
		let url = getURLForImage(imageName: imageName, folderName: folderName)
		else{ return }


		do {
			try data.write(to: url)
		} catch let error {
			print("error \(error)")
		}
	}

//	private func createFolderNeeded()

	private func getURLForFolder(foldername: String) -> URL? {

		guard let url = FileManager.default.urls(for: .cachesDirectory, in: .userDomainMask).first else{
			return nil

		}
		return url.appendingPathComponent(foldername)

	}

	private func getURLForImage(imageName: String, folderName: String) -> URL? {

		guard let folderurl = getURLForFolder(foldername: folderName) else{
			return nil

		}
		return folderurl.appendingPathComponent(imageName + ".png")

	}
}
