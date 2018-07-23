//
//  WinCombinationTest.swift
//  PokerHandShowdownTests
//
//  Created by Dzmitry Kudrashou on 2018-07-21.
//  Copyright © 2018 Dzmitry Kudrashou. All rights reserved.
//

import XCTest
@testable import PokerHandShowdown

class WinCombinationTest: XCTestCase {
	
	///support function
	func cardMasks(_ masks:[(CardMaskItem, CardMaskSuite)]) -> [CardMask] {
		var returnValue:[CardMaskModel] = []
		for (item, mask) in masks {
			let cardMask = CardMaskModel.init(item: item, suite: mask)
			returnValue.append(cardMask)
		}
		return returnValue
	}
	
	func cardMasks(_ masks:(CardMaskItem, CardMaskSuite)...) -> [CardMask] {
		return self.cardMasks(masks)
	}
	
	func winCombination(_ masks:[(CardMaskItem, CardMaskSuite)]) -> WinCombination {
		let cards = self.cardMasks(masks)
		return WinCombination.init(winCombinationType:.highCard, cardsMask:cards, rating:0)
	}
	
	func winCombination(_ masks:(CardMaskItem, CardMaskSuite)...) -> WinCombination {
		return self.winCombination(masks)
	}
	
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
	
	func testInitialization() {
		let fullHouseMask:[CardMask] = self.cardMasks((.any, .any), (.equal, .any), (.equal, .any), (.any, .any), (.equal, .any))
		XCTAssertEqual(WinCombinationType.allCases.count, 10)
		for combinationType in WinCombinationType.allCases {
			
			let rand = Int(arc4random_uniform(1000))
			let combination = WinCombination.init(winCombinationType:combinationType, cardsMask:fullHouseMask, rating:rand)
			XCTAssertEqual(combination.winCombinationType, combinationType)
			XCTAssertEqual(combination.rating, rand)
			XCTAssertEqual(combination.cardsMask.count, fullHouseMask.count)
			XCTAssertTrue(fullHouseMask.elementsEqual(combination.cardsMask, by: { $0.item == $1.item && $0.suite == $1.suite }))
		}
		
	}
	
	func testAny() {
		let cardsEmpty = [Card]()
		let cards = CardModelFactory.cards("AC", "4D", "6D", "KS", "QC")
		
		let winCombinationFaill = self.winCombination((.any, .any), (.any, .any), (.any, .any), (.any, .any), (.any, .any), (.any, .any))
		let winCombinationEmplty = self.winCombination()
		
		let winCombinationsPass = [
			self.winCombination((.any, .any), (.any, .any), (.any, .any), (.any, .any), (.any, .any)),
			self.winCombination((.any, .any), (.any, .any), (.any, .any), (.any, .any)),
			self.winCombination((.any, .any), (.any, .any), (.any, .any)),
			self.winCombination((.any, .any), (.any, .any)),
			self.winCombination((.any, .any)),
		]
		
		XCTAssertFalse(winCombinationFaill.isWin(cards))
		XCTAssertEqual(winCombinationFaill.winCards(cards).count, 0)
		
		XCTAssertFalse(winCombinationFaill.isWin(cardsEmpty))
		XCTAssertEqual(winCombinationFaill.winCards(cardsEmpty).count, 0)
		
		for winCombination in winCombinationsPass {
			XCTAssertTrue(winCombination.isWin(cards))
			XCTAssertEqual(winCombination.winCards(cards).count, winCombination.cardsMask.count)
		}
		
		XCTAssertTrue(winCombinationEmplty.isWin(cards))
		XCTAssertTrue(winCombinationEmplty.isWin(cardsEmpty))
		XCTAssertEqual(winCombinationEmplty.winCards(cards).count, 0)
		XCTAssertEqual(winCombinationEmplty.winCards(cardsEmpty).count, 0)
	}
	
	func testItems() {
		let equatableItems:[(CardItem, CardMaskItem)] = [
			(.two, .two),
			(.three, .three),
			(.four, .four),
			(.five, .five),
			(.six, .six),
			(.seven, .seven),
			(.eight, .eight),
			(.nine, .nine),
			(.ten, .ten),
			(.jack, .jack),
			(.queen, .queen),
			(.king, .king),
			(.ace, .ace),
		]
		
		for (cardItem, maskItem) in equatableItems {
			for cardSuite in CardSuite.allCases {
				let card = CardModelFactory.card(cardItem, cardSuite)
				for item in CardMaskItem.allCases {
					let winCombination = self.winCombination((item, .any))
					if item == maskItem || item == .any || item == .high {
						XCTAssertTrue(winCombination.isWin([card]))
						XCTAssertEqual(winCombination.winCards([card]).count, 1)
					}
					else {
						XCTAssertFalse(winCombination.isWin([card]))
						XCTAssertEqual(winCombination.winCards([card]).count, 0)
					}
				}
			}
		}
	}
	
	func testEqual() {
		let cardsEmpty = [Card]()
		let cards = CardModelFactory.cards("AC", "AD", "6D", "KS", "QH")
		
		
		
		let winCombinationOneItemFail = self.winCombination((.equal, .any))
		let winCombinationItemPass = self.winCombination((.ace, .any), (.equal, .any))
		let winCombinationItemFail = self.winCombination((.ace, .any), (.equal, .any), (.equal, .any))
		
		let winCombinationOneSuiteFail = self.winCombination((.any, .equal))
		let winCombinationSuitePass = self.winCombination((.any, .any), (.any, .equal))
		let winCombinationSuiteFail = self.winCombination((.any, .any), (.any, .equal), (.any, .equal))
		
		//test fail items
		XCTAssertFalse(winCombinationOneItemFail.isWin(cardsEmpty))
		XCTAssertFalse(winCombinationOneItemFail.isWin(cards))
		XCTAssertEqual(winCombinationOneItemFail.winCards(cardsEmpty).count, 0)
		XCTAssertEqual(winCombinationOneItemFail.winCards(cards).count, 0)
		
		XCTAssertFalse(winCombinationItemFail.isWin(cardsEmpty))
		XCTAssertFalse(winCombinationItemFail.isWin(cards))
		XCTAssertEqual(winCombinationItemFail.winCards(cardsEmpty).count, 0)
		XCTAssertEqual(winCombinationItemFail.winCards(cards).count, 0)
		
		
		
		//test fail suites
		XCTAssertFalse(winCombinationOneSuiteFail.isWin(cardsEmpty))
		XCTAssertFalse(winCombinationOneSuiteFail.isWin(cards))
		XCTAssertEqual(winCombinationOneSuiteFail.winCards(cardsEmpty).count, 0)
		XCTAssertEqual(winCombinationOneSuiteFail.winCards(cards).count, 0)
		
		XCTAssertFalse(winCombinationSuiteFail.isWin(cardsEmpty))
		XCTAssertFalse(winCombinationSuiteFail.isWin(cards))
		XCTAssertEqual(winCombinationSuiteFail.winCards(cardsEmpty).count, 0)
		XCTAssertEqual(winCombinationSuiteFail.winCards(cards).count, 0)
		
		//test pass items
		XCTAssertFalse(winCombinationItemPass.isWin(cardsEmpty))
		XCTAssertTrue(winCombinationItemPass.isWin(cards))
		XCTAssertEqual(winCombinationItemPass.winCards(cardsEmpty).count, 0)
		let winCardsItemPass = winCombinationItemPass.winCards(cards)
		XCTAssertEqual(winCardsItemPass.count, 2)
		for card in winCardsItemPass {
			XCTAssertEqual(card.item, .ace)
		}
		
		
		//test pass suite
		XCTAssertFalse(winCombinationSuitePass.isWin(cardsEmpty))
		XCTAssertTrue(winCombinationSuitePass.isWin(cards))
		XCTAssertEqual(winCombinationSuitePass.winCards(cardsEmpty).count, 0)
		let winCardsSuitePass = winCombinationSuitePass.winCards(cards)
		XCTAssertEqual(winCardsSuitePass.count, 2)
		for card in winCardsSuitePass {
			XCTAssertEqual(card.suite, .diamond)
		}
	}
	
	func testNext() {
		let cardsEmpty = [Card]()
		let cards = CardModelFactory.cards("9C", "3D", "6D", "KS", "QC")
		
		let winCombinationOneItemFail = self.winCombination((.next, .any))
		let winCombinationItemPass = self.winCombination((.any, .any), (.next, .any))
		let winCombinationItemFail = self.winCombination((.ace, .any), (.next, .any), (.next, .any))
		
		
		XCTAssertFalse(winCombinationOneItemFail.isWin(cardsEmpty))
		XCTAssertFalse(winCombinationItemPass.isWin(cardsEmpty))
		XCTAssertFalse(winCombinationItemFail.isWin(cardsEmpty))
		
		XCTAssertEqual(winCombinationOneItemFail.winCards(cardsEmpty).count, 0)
		XCTAssertEqual(winCombinationItemPass.winCards(cardsEmpty).count, 0)
		XCTAssertEqual(winCombinationItemFail.winCards(cardsEmpty).count, 0)
		
		XCTAssertFalse(winCombinationOneItemFail.isWin(cards))
		XCTAssertTrue(winCombinationItemPass.isWin(cards))
		XCTAssertFalse(winCombinationItemFail.isWin(cards))
		
		XCTAssertEqual(winCombinationOneItemFail.winCards(cards).count, 0)
		XCTAssertEqual(winCombinationItemPass.winCards(cards).count, 2)
		XCTAssertEqual(winCombinationItemFail.winCards(cards).count, 0)
		
		XCTAssertTrue(winCombinationItemPass.winCards(cards).contains { $0.item == .king && $0.suite == .spade })
		XCTAssertTrue(winCombinationItemPass.winCards(cards).contains { $0.item == .queen && $0.suite == .club })
	}
	
	func testHighestItem() {
		let cardsEmpty = [Card]()
		let cards = CardModelFactory.cards("KC", "AD", "6D", "QS", "QC")
		let winCombination = self.winCombination((.high, .any))
		let winCombinationSecond = self.winCombination((.high, .any), (.high, .any))
		
		
		XCTAssertFalse(winCombination.isWin(cardsEmpty))
		XCTAssertEqual(winCombination.winCards(cardsEmpty).count, 0)
		XCTAssertTrue(winCombination.isWin(cards))
		XCTAssertEqual(winCombination.winCards(cards).count, 1)
		XCTAssertTrue(winCombination.winCards(cards).contains { $0.item == .ace && $0.suite == .diamond })
		
		XCTAssertTrue(winCombinationSecond.isWin(cards))
		XCTAssertEqual(winCombinationSecond.winCards(cards).count, 2)
		XCTAssertTrue(winCombinationSecond.winCards(cards).contains { $0.item == .ace && $0.suite == .diamond })
		XCTAssertTrue(winCombinationSecond.winCards(cards).contains { $0.item == .king && $0.suite == .club })
	}
	
	
	
	func testHighestCard() {
		let cardsHigh = CardModelFactory.cards("KC", "AD", "6D", "QS", "QC")
		let cardsMid = CardModelFactory.cards("KC", "KD", "5D", "QS", "QC")
		let cardsLow = CardModelFactory.cards("KC", "QD", "5D", "QS", "QC")
		let winCombination = WinCombinationFactory.winCombination(for:.highCard)
		
		XCTAssertTrue(winCombination.isWin(cardsHigh))
		XCTAssertTrue(winCombination.isWin(cardsMid))
		XCTAssertTrue(winCombination.isWin(cardsLow))
		XCTAssertEqual(winCombination.winCards(cardsHigh).count, 1)
		XCTAssertEqual(winCombination.winCards(cardsMid).count, 1)
		XCTAssertEqual(winCombination.winCards(cardsLow).count, 1)
		
		XCTAssertGreaterThan(winCombination.rating(cardsHigh), winCombination.rating(cardsMid))
		XCTAssertGreaterThan(winCombination.rating(cardsMid), winCombination.rating(cardsLow))
		
	}
	
	func testOnePair() {
		let cardsFail = CardModelFactory.cards("KC", "AD", "6D", "5S", "QC")
		let cardsHigh = CardModelFactory.cards("KC", "AD", "6D", "QS", "QC")
		let cardsMid = CardModelFactory.cards("KC", "AD", "6D", "JS", "JC")
		let cardsLow = CardModelFactory.cards("QC", "AD", "6D", "JS", "JC")
		let winCombination = WinCombinationFactory.winCombination(for:.onePair)
		
		XCTAssertFalse(winCombination.isWin(cardsFail))
		XCTAssertTrue(winCombination.isWin(cardsHigh))
		XCTAssertTrue(winCombination.isWin(cardsMid))
		XCTAssertTrue(winCombination.isWin(cardsLow))
		XCTAssertEqual(winCombination.winCards(cardsHigh).count, 2)
		XCTAssertEqual(winCombination.winCards(cardsMid).count, 2)
		XCTAssertEqual(winCombination.winCards(cardsLow).count, 2)
		
		XCTAssertGreaterThan(winCombination.rating(cardsHigh), winCombination.rating(cardsMid))
		XCTAssertGreaterThan(winCombination.rating(cardsMid), winCombination.rating(cardsLow))
	}
	
	func testTwoPair() {
		let cardsFail = CardModelFactory.cards("KC", "AD", "QD", "QS", "QC")
		let cardsHigh = CardModelFactory.cards("KC", "KD", "6D", "QS", "QC")
		let cardsMid = CardModelFactory.cards("KC", "KD", "6D", "JS", "JC")
		let cardsLow = CardModelFactory.cards("KC", "KD", "5D", "JS", "JC")
		let winCombination = WinCombinationFactory.winCombination(for:.twoPair)
		
		XCTAssertFalse(winCombination.isWin(cardsFail))
		XCTAssertTrue(winCombination.isWin(cardsHigh))
		XCTAssertTrue(winCombination.isWin(cardsMid))
		XCTAssertTrue(winCombination.isWin(cardsLow))
		XCTAssertEqual(winCombination.winCards(cardsHigh).count, 4)
		XCTAssertEqual(winCombination.winCards(cardsMid).count, 4)
		XCTAssertEqual(winCombination.winCards(cardsLow).count, 4)
		
		XCTAssertGreaterThan(winCombination.rating(cardsHigh), winCombination.rating(cardsMid))
		XCTAssertGreaterThan(winCombination.rating(cardsMid), winCombination.rating(cardsLow))
	}
	
	func testTreeOfAKind() {
		let cardsFail = CardModelFactory.cards("KC", "AD", "JD", "QS", "QC")
		let cardsHigh = CardModelFactory.cards("KC", "QD", "6D", "QS", "QC")
		let cardsMid = CardModelFactory.cards("KC", "JD", "6D", "JS", "JC")
		let cardsLow = CardModelFactory.cards("QC", "JD", "6D", "JS", "JC")
		let winCombination = WinCombinationFactory.winCombination(for:.treeOfAKind)
		
		XCTAssertFalse(winCombination.isWin(cardsFail))
		XCTAssertTrue(winCombination.isWin(cardsHigh))
		XCTAssertTrue(winCombination.isWin(cardsMid))
		XCTAssertTrue(winCombination.isWin(cardsLow))
		XCTAssertEqual(winCombination.winCards(cardsHigh).count, 3)
		XCTAssertEqual(winCombination.winCards(cardsMid).count, 3)
		XCTAssertEqual(winCombination.winCards(cardsLow).count, 3)
		
		XCTAssertGreaterThan(winCombination.rating(cardsHigh), winCombination.rating(cardsMid))
		XCTAssertGreaterThan(winCombination.rating(cardsMid), winCombination.rating(cardsLow))
	}
	
	func testStraight() {
		let cardsFail = CardModelFactory.cards("KC", "AD", "JD", "QS", "QC")
		let cardsHigh = CardModelFactory.cards("5C", "6D", "8D", "7S", "9C")
		let cardsMid = CardModelFactory.cards("5C", "6D", "8D", "7S", "4C")
		let cardsLow = CardModelFactory.cards("5C", "6D", "3D", "7S", "4C")
		let winCombination = WinCombinationFactory.winCombination(for:.straight)
		
		XCTAssertFalse(winCombination.isWin(cardsFail))
		XCTAssertTrue(winCombination.isWin(cardsHigh))
		XCTAssertTrue(winCombination.isWin(cardsMid))
		XCTAssertTrue(winCombination.isWin(cardsLow))
		XCTAssertEqual(winCombination.winCards(cardsHigh).count, 5)
		XCTAssertEqual(winCombination.winCards(cardsMid).count, 5)
		XCTAssertEqual(winCombination.winCards(cardsLow).count, 5)
		
		XCTAssertGreaterThan(winCombination.rating(cardsHigh), winCombination.rating(cardsMid))
		XCTAssertGreaterThan(winCombination.rating(cardsMid), winCombination.rating(cardsLow))
	}
	
	func testFlush() {
		let cardsFail = CardModelFactory.cards("KC", "AD", "JD", "QS", "QC")
		let cardsHigh = CardModelFactory.cards("5D", "6D", "8D", "7D", "9D")
		let cardsMid = CardModelFactory.cards("5D", "6D", "8D", "7D", "8D")
		let cardsLow = CardModelFactory.cards("5D", "5D", "8D", "7D", "8D")
		let winCombination = WinCombinationFactory.winCombination(for:.flush)
		
		XCTAssertFalse(winCombination.isWin(cardsFail))
		XCTAssertTrue(winCombination.isWin(cardsHigh))
		XCTAssertTrue(winCombination.isWin(cardsMid))
		XCTAssertTrue(winCombination.isWin(cardsLow))
		XCTAssertEqual(winCombination.winCards(cardsHigh).count, 5)
		XCTAssertEqual(winCombination.winCards(cardsMid).count, 5)
		XCTAssertEqual(winCombination.winCards(cardsLow).count, 5)
		
		XCTAssertGreaterThan(winCombination.rating(cardsHigh), winCombination.rating(cardsMid))
		XCTAssertGreaterThan(winCombination.rating(cardsMid), winCombination.rating(cardsLow))
	}
	
	func testFullHouse() {
		let cardsFail = CardModelFactory.cards("KC", "AD", "QS", "QS", "QC")
		let cardsHigh = CardModelFactory.cards("5D", "5C", "8S", "8D", "8D")
		let cardsMid = CardModelFactory.cards("5D", "5C", "7S", "7D", "7D")
		let cardsLow = CardModelFactory.cards("4D", "4C", "7S", "7D", "7D")
		let winCombination = WinCombinationFactory.winCombination(for:.fullHouse)
		
		XCTAssertFalse(winCombination.isWin(cardsFail))
		XCTAssertTrue(winCombination.isWin(cardsHigh))
		XCTAssertTrue(winCombination.isWin(cardsMid))
		XCTAssertTrue(winCombination.isWin(cardsLow))
		XCTAssertEqual(winCombination.winCards(cardsHigh).count, 5)
		XCTAssertEqual(winCombination.winCards(cardsMid).count, 5)
		XCTAssertEqual(winCombination.winCards(cardsLow).count, 5)
		
		XCTAssertGreaterThan(winCombination.rating(cardsHigh), winCombination.rating(cardsMid))
		XCTAssertGreaterThan(winCombination.rating(cardsMid), winCombination.rating(cardsLow))
		
	}
	
	func testFourOfAKind() {
		let cardsFail = CardModelFactory.cards("KC", "AD", "QS", "QS", "QC")
		let cardsHigh = CardModelFactory.cards("5D", "8C", "8S", "8D", "8D")
		let cardsMid = CardModelFactory.cards("4D", "8C", "8S", "8D", "8D")
		let cardsLow = CardModelFactory.cards("4D", "7C", "7S", "7D", "7D")
		let winCombination = WinCombinationFactory.winCombination(for:.fourOfAKind)
		
		XCTAssertFalse(winCombination.isWin(cardsFail))
		XCTAssertTrue(winCombination.isWin(cardsHigh))
		XCTAssertTrue(winCombination.isWin(cardsMid))
		XCTAssertTrue(winCombination.isWin(cardsLow))
		XCTAssertEqual(winCombination.winCards(cardsHigh).count, 4)
		XCTAssertEqual(winCombination.winCards(cardsMid).count, 4)
		XCTAssertEqual(winCombination.winCards(cardsLow).count, 4)
		
		XCTAssertGreaterThan(winCombination.rating(cardsHigh), winCombination.rating(cardsMid))
		XCTAssertGreaterThan(winCombination.rating(cardsMid), winCombination.rating(cardsLow))
	}
	
	func testStraightFlush() {
		let cardsFail = CardModelFactory.cards("5C", "6D", "8D", "7S", "9C")
		let cardsHigh = CardModelFactory.cards("5C", "6C", "8C", "7C", "9C")
		let cardsMid = CardModelFactory.cards("5C", "6C", "8C", "7C", "4C")
		let cardsLow = CardModelFactory.cards("5C", "6C", "3C", "7C", "4C")
		let winCombination = WinCombinationFactory.winCombination(for:.straightFlush)
		
		XCTAssertFalse(winCombination.isWin(cardsFail))
		XCTAssertTrue(winCombination.isWin(cardsHigh))
		XCTAssertTrue(winCombination.isWin(cardsMid))
		XCTAssertTrue(winCombination.isWin(cardsLow))
		XCTAssertEqual(winCombination.winCards(cardsHigh).count, 5)
		XCTAssertEqual(winCombination.winCards(cardsMid).count, 5)
		XCTAssertEqual(winCombination.winCards(cardsLow).count, 5)
		
		XCTAssertGreaterThan(winCombination.rating(cardsHigh), winCombination.rating(cardsMid))
		XCTAssertGreaterThan(winCombination.rating(cardsMid), winCombination.rating(cardsLow))
	}
	
	func testRoyalFlush() {
		
		let cardsFail = CardModelFactory.cards("5C", "6C", "8C", "7C", "9C")
		let cardsHigh = CardModelFactory.cards("AC", "KC", "QC", "JC", "10C")
		let cardsMid = CardModelFactory.cards("AD", "KD", "QD", "JD", "10D")
		let winCombination = WinCombinationFactory.winCombination(for:.royalFlush)
		
		XCTAssertFalse(winCombination.isWin(cardsFail))
		XCTAssertTrue(winCombination.isWin(cardsHigh))
		XCTAssertTrue(winCombination.isWin(cardsMid))
		XCTAssertEqual(winCombination.winCards(cardsHigh).count, 5)
		XCTAssertEqual(winCombination.winCards(cardsMid).count, 5)
		
		XCTAssertEqual(winCombination.rating(cardsHigh), winCombination.rating(cardsMid))
	}
}
