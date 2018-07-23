//
//  CardModel.swift
//  PokerHandShowdown
//
//  Created by Dzmitry Kudrashou on 2018-07-21.
//  Copyright © 2018 Dzmitry Kudrashou. All rights reserved.
//

///Contains information about card
public struct CardModel : Card {
	//MARK: - Stired properties
	public private(set) var item: CardItem
	public private(set) var suite: CardSuite
	//MARK: - Computed properties
	public var rating: Int {
		return self.item.rawValue
	}
	
	//MARK: - initializations
	init(item:CardItem, suite:CardSuite) {
		self.item = item
		self.suite = suite
	}
}
