//
//  PlayerFactory.swift
//  PokerHandShowdown
//
//  Created by Dzmitry Kudrashou on 2018-07-22.
//  Copyright © 2018 Dzmitry Kudrashou. All rights reserved.
//


///Is used to create new players with cards
///each player needs to have only 5 cards
public class PlayerFactory {
	//MARK: - initializations
	private init () {
		
	}
	
	//MARK: - Type methods
	///If player has not 5 cards, return nil
	public class func player(name:String, cards cardsKeys:String...) -> Player? {
		return self.player(name:name, cards:cardsKeys)
	}
	
	///If player has not 5 cards, return nil
	public class func player(name:String, cards cardsKeys:[String]) -> Player? {
		let cards = CardModelFactory.cards(cardsKeys)
		return Player.init(name:name, cards:cards)
	}
}
