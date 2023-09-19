//
//  PortfolioDataService.swift
//  SwiftCryptoTracker
//
//  Created by Peter Delgado on 19/9/23.
//

import Foundation
import CoreData

class PortfolioDataService{

	private let container: NSPersistentContainer
	private let containerName: String = "PortfolioContainer"
	private let entityName: String = "PortfolioEntiy"

	@Published var savedEntities: [PortfolioEntity] = []

	init(){
		container = NSPersistentContainer(name: containerName)
		container.loadPersistentStores { (_, error) in
			if let error = error {
				print("Error loading Core Data! \(error)")
			}
		}
		}

	    private func getPortfolio() {
		let request = NSFetchRequest<PortfolioEntity>(entityName: entityName)
			do {
				try container.viewContext.fetch(request)
			} catch let error {
				print("Error fetching Portfolio Entities.\(error)")
			}
	}

	private func add(coin: CoinModel, amount: Double) {
		let entity = PortfolioEntity(context: container.viewContext)
		entity.coinID = coin.id
		entity.amount = amount

	}
}
