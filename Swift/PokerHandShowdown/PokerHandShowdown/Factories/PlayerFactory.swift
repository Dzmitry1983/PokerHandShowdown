//
//  PlayerFactory.swift
//  PokerHandShowdown
//
//  Created by Dzmitry Kudrashou on 2018-07-22.
//  Copyright © 2018 Dzmitry Kudrashou. All rights reserved.
//

public class PlayerFactory {
	//MARK: - initializations
	private init () {
		
	}
	
	//MARK: - Type methods
	public class func player(name:String, cards cardsKeys:String...) -> Player? {
		return self.player(name:name, cards:cardsKeys)
	}
	
	public class func player(name:String, cards cardsKeys:[String]) -> Player? {
		let cards = CardModelFactory.cards(cardsKeys)
		return Player.init(name:name, cards:cards)
	}
}
