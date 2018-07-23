//
//  WinCombination.swift
//  PokerHandShowdown
//
//  Created by Dzmitry Kudrashou on 2018-07-21.
//  Copyright © 2018 Dzmitry Kudrashou. All rights reserved.
//

///regular poker subset names
///Enum inheritances from int to has a rating
enum WinCombinationType : Int, CaseIterable {
	case highCard = 1
	case onePair
	case twoPair
	case treeOfAKind
	case straight
	case flush
	case fullHouse
	case fourOfAKind
	case straightFlush
	case royalFlush
	
	@available(swift, obsoleted: 4.2)
	static let allCases: [WinCombinationType] = [highCard, onePair, twoPair, treeOfAKind, straight, flush, fullHouse, fourOfAKind, straightFlush, royalFlush]
}


///This class checks if a hand is confirm a winning combination
class WinCombination {

	//MARK: - Stored properties
	private(set) var cardsMask:[CardMask]
	private(set) var winCombinationType:WinCombinationType
	private(set) var rating:Int
	
	//MARK: - initializations
	init(winCombinationType:WinCombinationType, cardsMask:[CardMask], rating:Int) {
		self.cardsMask = cardsMask
		self.winCombinationType = winCombinationType
		self.rating = rating
	}
	
	//MARK: - private methods
	private func isSuitePass(mask:CardMask, currentCard:Card, previousCard:Card? = nil) -> Bool {
		switch mask.suite {
		case .any:
			return true
		case .equal:
			guard let pCard = previousCard else {
				return false
			}
			return currentCard.suite == pCard.suite
		}
	}
	
	private func isItemPass(mask:CardMask, currentCard:Card, previousCard:Card? = nil) -> Bool {
		switch mask.item {
		case .two:
			return currentCard.item == .two
		case .three:
			return currentCard.item == .three
		case .four:
			return currentCard.item == .four
		case .five:
			return currentCard.item == .five
		case .six:
			return currentCard.item == .six
		case .seven:
			return currentCard.item == .seven
		case .eight:
			return currentCard.item == .eight
		case .nine:
			return currentCard.item == .nine
		case .ten:
			return currentCard.item == .ten
		case .jack:
			return currentCard.item == .jack
		case .queen:
			return currentCard.item == .queen
		case .king:
			return currentCard.item == .king
		case .ace:
			return currentCard.item == .ace
		case .any:
			return true
		case .equal:
			guard let pCard = previousCard else {
				return false
			}
			return currentCard.item == pCard.item
		case .high:
			//return true becouse cards were sorted
			return true
		case .next:
			guard let pCard = previousCard else {
				return false
			}
			return currentCard.item.rawValue == (pCard.item.rawValue + 1)
		}
	}
	
	private func isCardPass(mask:CardMask, currentCard:Card, previousCard:Card? = nil) -> Bool {
		return self.isItemPass(mask:mask, currentCard:currentCard, previousCard:previousCard) &&
			self.isSuitePass(mask:mask, currentCard:currentCard, previousCard:previousCard)
	}
	
	private func passedCards(masks:[CardMask], cards:[Card], previousCard:Card? = nil) -> (isOk:Bool, cards:[Card], tail:[Card]) {
		var returnValue:(isOk:Bool, cards:[Card], tail:[Card]) = (masks.count == 0, [], [])
		if returnValue.isOk {
			returnValue.tail = cards
		}
		if masks.count > 0 {
			var masksTail = masks
			let mask = masksTail.removeFirst()
			
			for (index, card) in cards.enumerated() {
				var cardsTail = cards
				cardsTail.remove(at: index)
				if self.isCardPass(mask:mask, currentCard:card, previousCard: previousCard) {
					returnValue = self.passedCards(masks:masksTail, cards:cardsTail, previousCard:card)
				}
				
				if returnValue.isOk {
					returnValue.cards.insert(card, at:0)
					break;
				}
			}
		}
		return returnValue
	}
	
	//MARK: - public methods
	///check hand for winning this combination
	func isWin(_ hand:Hand) -> Bool {
		return self.isWin(hand.cards)
	}
	
	func isWin(_ cards:[Card]) -> Bool {
		return self.passedCards(masks:self.cardsMask, cards:cards).isOk
	}
	
	func winCards(_ cards:[Card]) -> [Card] {
		if (self.cardsMask.count <= cards.count) {
			let sortedCards = cards.sorted(by: { $0.item.rawValue > $1.item.rawValue })
			return self.passedCards(masks:self.cardsMask, cards:sortedCards).cards
		}
		return [Card]()
	}
	
	
	///calculate hand rating for this combination
	func rating(_ hand:Hand) -> WinCombinationRating{
		return self.rating(hand.cards)
	}
	
	func rating(_ cards:[Card]) -> WinCombinationRating {
		let winCards:[Card]
		let tailCards:[Card]
		let rating = WinCombinationRating()
		
		if (self.cardsMask.count <= cards.count) {
			let sortedCards = cards.sorted(by: { $0.item.rawValue > $1.item.rawValue })
			let result = self.passedCards(masks:self.cardsMask, cards:sortedCards)
			winCards = result.cards
			tailCards = result.tail
			if result.isOk {
				rating.combination = self.rating
			}
		}
		else {
			winCards = []
			tailCards = cards
		}
		
		for card in winCards {
			rating.winCards.append(card.item.rawValue)
		}
		
		for card in tailCards {
			rating.unWinCards.append(card.item.rawValue)
		}
		return rating
	}
}

//MARK: - Nested Types
extension WinCombination {
	
	///This class is used to compare win combinations
	class WinCombinationRating : Comparable {
		
		var combination:Int = 0
		var winCards:[Int] = []
		var unWinCards:[Int] = []
		
		//MARK: - Comparable
		public static func < (lhs:WinCombinationRating, rhs:WinCombinationRating) -> Bool {
			if lhs.combination != rhs.combination {
				return lhs.combination < rhs.combination
			}
			if lhs.winCards != rhs.winCards {
				if lhs.winCards.count == rhs.winCards.count {
					for index in 0..<lhs.winCards.count {
						if lhs.winCards[index] != rhs.winCards[index] {
							return lhs.winCards[index] < rhs.winCards[index]
						}
					}
				}
				else {
					return lhs.winCards.count < rhs.winCards.count
				}
			}
			
			if lhs.unWinCards != rhs.unWinCards {
				if lhs.unWinCards.count == rhs.unWinCards.count {
					for index in 0..<lhs.unWinCards.count {
						if lhs.unWinCards[index] != rhs.unWinCards[index] {
							return lhs.unWinCards[index] < rhs.unWinCards[index]
						}
					}
				}
				else {
					return lhs.unWinCards.count < rhs.unWinCards.count
				}
			}
			return false
		}

		static func == (lhs: WinCombinationRating, rhs: WinCombinationRating) -> Bool {
			return lhs.combination == rhs.combination && lhs.winCards == rhs.winCards && lhs.unWinCards == rhs.unWinCards
		}
	}
}
