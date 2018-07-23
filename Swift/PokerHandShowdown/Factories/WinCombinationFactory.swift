//
//  WinCombinationFactory.swift
//  PokerHandShowdown
//
//  Created by Dzmitry Kudrashou on 2018-07-21.
//  Copyright © 2018 Dzmitry Kudrashou. All rights reserved.
//



///Helps to create new WinCombination objects
class WinCombinationFactory {
	
	//MARK: - initializations
	private init () {
		
	}
	
	//MARK: - private methods
	private static func cardMasks(_ elements:(CardMaskItem, CardMaskSuite)...) -> [CardMask] {
		var returnValue:[CardMaskModel] = []
		for (item, mask) in elements {
			let cardMask = CardMaskModel.init(item: item, suite: mask)
			returnValue.append(cardMask)
		}
		return returnValue
	}
	
	//MARK: - Type methods
	class func winCombination(for winCombination:WinCombinationType) -> WinCombination {
		let cardMasks:[CardMask]
		switch winCombination {
		case .highCard:
			cardMasks = self.cardMasks((CardMaskItem.high, CardMaskSuite.any))
		case .onePair:
			cardMasks = self.cardMasks((CardMaskItem.any, CardMaskSuite.any), (.equal, .any))
		case .twoPair:
			cardMasks = self.cardMasks((CardMaskItem.any, CardMaskSuite.any), (.equal, .any), (.any, .any), (.equal, .any))
		case .treeOfAKind:
			cardMasks = self.cardMasks((.any, .any), (.equal, .any), (.equal, .any))
		case .straight:
			cardMasks = self.cardMasks((.any, .any), (.next, .any), (.next, .any), (.next, .any), (.next, .any))
		case .flush:
			cardMasks = self.cardMasks((.any, .any), (.any, .equal), (.any, .equal), (.any, .equal), (.any, .equal))
		case .fullHouse:
			cardMasks = self.cardMasks((.any, .any), (.equal, .any), (.equal, .any), (.any, .any), (.equal, .any))
		case .fourOfAKind:
			cardMasks = self.cardMasks((.any, .any), (.equal, .any), (.equal, .any), (.equal, .any))
		case .straightFlush:
			cardMasks = self.cardMasks((.any, .any), (.next, .equal), (.next, .equal), (.next, .equal), (.next, .equal))
		case .royalFlush:
			cardMasks = self.cardMasks((.ten, .any), (.jack, .equal), (.queen, .equal), (.king, .equal), (.ace, .equal))
		
		}
		return WinCombination.init(winCombinationType:winCombination, cardsMask:cardMasks, rating:winCombination.rawValue)
	}
	
}
