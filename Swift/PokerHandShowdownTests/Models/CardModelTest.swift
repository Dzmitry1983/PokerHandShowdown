//
//  CardModelTest.swift
//  PokerHandShowdownTests
//
//  Created by Dzmitry Kudrashou on 2018-07-22.
//  Copyright © 2018 Dzmitry Kudrashou. All rights reserved.
//

import XCTest
@testable import PokerHandShowdown

class CardModelTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

	///test enumirations to combinations count and unique
	func testEnumerations() {
		XCTAssertEqual(CardSuite.allCases.count, 4)
		XCTAssertEqual(CardItem.allCases.count, 13)
		
		XCTAssertEqual(CardSuite.allCases.count, Set(CardSuite.allCases).count)
		XCTAssertEqual(CardItem.allCases.count, Set(CardItem.allCases).count)
		
		var failUniqueSuite = Array(CardSuite.allCases)
		var failUniqueItem = Array(CardItem.allCases)
		failUniqueSuite.append(.diamond)
		failUniqueItem.append(.two)
		XCTAssertGreaterThan(failUniqueSuite.count, Set(failUniqueSuite).count)
		XCTAssertGreaterThan(failUniqueItem.count, Set(failUniqueItem).count)
	}
	
	///Rating card needs to be different for different items
    func testCardRatings() {
		XCTAssertLessThan(CardModel(item: .two, suite: .diamond).rating, CardModel(item: .three, suite: .diamond).rating)
		XCTAssertLessThan(CardModel(item: .three, suite: .diamond).rating, CardModel(item: .four, suite: .diamond).rating)
		XCTAssertLessThan(CardModel(item: .four, suite: .diamond).rating, CardModel(item: .five, suite: .diamond).rating)
		XCTAssertLessThan(CardModel(item: .five, suite: .diamond).rating, CardModel(item: .six, suite: .diamond).rating)
		XCTAssertLessThan(CardModel(item: .six, suite: .diamond).rating, CardModel(item: .seven, suite: .diamond).rating)
		XCTAssertLessThan(CardModel(item: .seven, suite: .diamond).rating, CardModel(item: .eight, suite: .diamond).rating)
		XCTAssertLessThan(CardModel(item: .eight, suite: .diamond).rating, CardModel(item: .nine, suite: .diamond).rating)
		XCTAssertLessThan(CardModel(item: .nine, suite: .diamond).rating, CardModel(item: .ten, suite: .diamond).rating)
		XCTAssertLessThan(CardModel(item: .ten, suite: .diamond).rating, CardModel(item: .jack, suite: .diamond).rating)
		XCTAssertLessThan(CardModel(item: .jack, suite: .diamond).rating, CardModel(item: .queen, suite: .diamond).rating)
		XCTAssertLessThan(CardModel(item: .queen, suite: .diamond).rating, CardModel(item: .king, suite: .diamond).rating)
		XCTAssertLessThan(CardModel(item: .king, suite: .diamond).rating, CardModel(item: .ace, suite: .diamond).rating)
		
    }
	
	///Test initialization for all cards
	func testCardsInitialization() {
		for item in CardItem.allCases {
			for suite in CardSuite.allCases {
				let card = CardModel(item: item, suite: suite)
				XCTAssertEqual(card.item, item)
				XCTAssertEqual(card.suite, suite)
				XCTAssertGreaterThanOrEqual(card.rating, CardItem.two.rawValue)
				XCTAssertLessThanOrEqual(card.rating, CardItem.ace.rawValue)
			}
		}
	}

}
