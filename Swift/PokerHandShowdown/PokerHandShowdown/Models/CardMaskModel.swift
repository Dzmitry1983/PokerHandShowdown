//
//  CardMaskModel.swift
//  PokerHandShowdown
//
//  Created by Dzmitry Kudrashou on 2018-07-21.
//  Copyright © 2018 Dzmitry Kudrashou. All rights reserved.
//


///Contains information about card mask, it will be used to search win combination
struct CardMaskModel : CardMask {
	//MARK: - Stired properties
	private(set) var suite: CardMaskSuite
	private(set) var item: CardMaskItem
	
	//MARK: - initializations
	init(item:CardMaskItem, suite:CardMaskSuite) {
		self.item = item
		self.suite = suite
	}
}
