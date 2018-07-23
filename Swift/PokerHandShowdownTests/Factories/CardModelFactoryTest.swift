//
//  CardModelFactoryTest.swift
//  PokerHandShowdownTests
//
//  Created by Dzmitry Kudrashou on 2018-07-22.
//  Copyright © 2018 Dzmitry Kudrashou. All rights reserved.
//

import XCTest
@testable import PokerHandShowdown

///This tast tests only factory and doesn't test card models
class CardModelFactoryTest: XCTestCase {

	let items:[(item:CardItem, code:String)] = [
		(item:.two, code:"2"),
		(item:.three, code:"3"),
		(item:.four, code:"4"),
		(item:.five, code:"5"),
		(item:.six, code:"6"),
		(item:.seven, code:"7"),
		(item:.eight, code:"8"),
		(item:.nine, code:"9"),
		(item:.ten, code:"10"),
		(item:.jack, code:"J"),
		(item:.queen, code:"Q"),
		(item:.king, code:"K"),
		(item:.ace, code:"A"),
	]
	
	let suites:[(suite:CardSuite, code:String)] = [
		(suite:CardSuite.club, code:"C"),
		(suite:CardSuite.diamond, code:"D"),
		(suite:CardSuite.heart, code:"H"),
		(suite:CardSuite.spade, code:"S"),
	]
	
	///support function
	func cardModels(_ elements:(CardItem, CardSuite)...) -> [Card] {
		var returnValue:[CardModel] = []
		for (item, mask) in elements {
			let cardMask = CardModel.init(item: item, suite: mask)
			returnValue.append(cardMask)
		}
		return returnValue
	}
	
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
	
	func testCardModelFromString() {
		XCTAssertEqual(items.count, CardItem.allCases.count)
		XCTAssertEqual(suites.count, CardSuite.allCases.count)
		
		XCTAssertNil(CardModelFactory.card(""))
		XCTAssertNil(CardModelFactory.card(" "))
		XCTAssertNil(CardModelFactory.card("3"))
		XCTAssertNil(CardModelFactory.card("D"))
		XCTAssertNil(CardModelFactory.card("3DD"))
		XCTAssertNil(CardModelFactory.card("33D"))
		
		for (item, itemCode) in items {
			for (suite, suiteCode) in suites {
				let card = CardModelFactory.card(itemCode + suiteCode)
				XCTAssertNotNil(card)
				XCTAssertEqual(card?.suite, suite)
				XCTAssertEqual(card?.item, item)
				XCTAssertNil(CardModelFactory.card(suiteCode + itemCode))
				XCTAssertNil(CardModelFactory.card(itemCode + " " + suiteCode))
				XCTAssertNil(CardModelFactory.card(itemCode + suiteCode + " "))
				XCTAssertNil(CardModelFactory.card(" " + itemCode + suiteCode))
			}
		}
	}
	
	func testCardModelsFromStrings() {
		for (item, itemCode) in items {
			var codes:[(CardItem, CardSuite, String)] = []
			for (suite, suiteCode) in suites {
				codes.append((item, suite, itemCode + suiteCode))
			}
			let cards = CardModelFactory.cards(codes.map({ $2 }))
			XCTAssertTrue(cards.elementsEqual(codes) { $0.item == $1.0 && $0.suite == $1.1})
			codes.append((CardItem.ace, CardSuite.spade, "3DD"))
			let cardsForOneFail = CardModelFactory.cards(codes.map({ $2 }))
			XCTAssertLessThan(cardsForOneFail.count, codes.count)
		}
	}
	
	func testCardModelFromTuples() {
		for item in CardItem.allCases {
			for suite in CardSuite.allCases {
				let card = CardModelFactory.card(item, suite)
				XCTAssertEqual(card.item, item)
				XCTAssertEqual(card.suite, suite)
				XCTAssertGreaterThanOrEqual(card.rating, CardItem.two.rawValue)
				XCTAssertLessThanOrEqual(card.rating, CardItem.ace.rawValue)
			}
		}
		
		
		let cards = CardModelFactory.cards((.two, .club), (.four, .diamond), (.king, .spade), (.ace, .heart))
		let cardsToCheck = CardModelFactory.cards("2C", "4D", "KS", "AH")
		XCTAssertEqual(cards.count, 4)
		XCTAssertTrue(cardsToCheck.elementsEqual(cards, by: { $0.item == $1.item && $0.suite == $1.suite }))
	}
	
}
