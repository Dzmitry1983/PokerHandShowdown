//
//  Player.swift
//  PokerHandShowdown
//
//  Created by Dzmitry Kudrashou on 2018-07-21.
//  Copyright © 2018 Dzmitry Kudrashou. All rights reserved.
//

///Contains infromation about player
public class Player : Hand {
	//MARK: - Type cosntant properties
	static let cardsCountIsNeededToGame = 5
	
	//MARK: - Stired properties
	public private(set) var cards:[Card]
	public private(set) var name:String
	
	//MARk: - initializations
	public init?(name:String, cards:[Card]) {
		if name.count == 0 || cards.count != Player.cardsCountIsNeededToGame {
			return nil
		} else {
			self.name = name
			self.cards = cards
		}
	}
}

