//
//  CardModelFactory.swift
//  PokerHandShowdown
//
//  Created by Dzmitry Kudrashou on 2018-07-22.
//  Copyright © 2018 Dzmitry Kudrashou. All rights reserved.
//


///Is used to create card models
///for example "2H", "3D", "4C", "5D", "10H"
public class CardModelFactory {
	
	//MARK: - Type cosntant properties
	private static let items:[String:CardItem] = [
		"2":.two,
		"3":.three,
		"4":.four,
		"5":.five,
		"6":.six,
		"7":.seven,
		"8":.eight,
		"9":.nine,
		"10":.ten,
		"J":.jack,
		"Q":.queen,
		"K":.king,
		"A":.ace,
	]
	
	private static let suits:[String:CardSuite] = [
		"C":CardSuite.club,
		"D":CardSuite.diamond,
		"S":CardSuite.spade,
		"H":CardSuite.heart,
	]
	
	//MARK: - initializations
	private init () {
		
	}
	
	//MARK: - Type methods
	///Create new card model from string, where last character is a suite and one firste
	///or two firsts are item
	///for example "2H", "3D", "4C", "5D", "10H"
	public class func card(_ from:String) -> CardModel? {
		var key = from.uppercased()
		if key.count == 2 || key.count == 3 {
			let last = String(key.removeLast())
			guard let item = self.items[key] else {
				return nil
			}
			
			guard let suite = self.suits[last] else {
				return nil
			}
			
			
			return CardModel.init(item:item, suite:suite)
		}
		return nil
	}
	
	public class func cards(_ from:[String]) -> [CardModel] {
		return from.compactMap({ self.card($0) })
	}
	
	public class func cards(_ from:String...) -> [CardModel] {
		return self.cards(from)
	}
	
	public class func card(_ cardItem:CardItem, _ cardSuite:CardSuite) -> CardModel {
		return CardModel.init(item:cardItem, suite:cardSuite)
	}
	
	public class func cards(_ cards:(CardItem, CardSuite)...) -> [CardModel] {
		return cards.map { CardModel(item:$0, suite:$1) }
	}
}
