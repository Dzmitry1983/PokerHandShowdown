//
//  CardMaskModelTest.swift
//  PokerHandShowdownTests
//
//  Created by Dzmitry Kudrashou on 2018-07-22.
//  Copyright © 2018 Dzmitry Kudrashou. All rights reserved.
//

import XCTest
@testable import PokerHandShowdown

class CardMaskModelTest: XCTestCase {

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
		XCTAssertEqual(CardMaskSuite.allCases.count, 2)
		XCTAssertEqual(CardMaskItem.allCases.count, 17)
		
		XCTAssertEqual(CardMaskSuite.allCases.count, Set(CardMaskSuite.allCases).count)
		XCTAssertEqual(CardMaskItem.allCases.count, Set(CardMaskItem.allCases).count)
		
		var failUniqueSuite = Array(CardMaskSuite.allCases)
		var failUniqueItem = Array(CardMaskItem.allCases)
		failUniqueSuite.append(.any)
		failUniqueItem.append(.any)
		XCTAssertGreaterThan(failUniqueSuite.count, Set(failUniqueSuite).count)
		XCTAssertGreaterThan(failUniqueItem.count, Set(failUniqueItem).count)
	}
	
	///Test initialization for all cards
	func testCardsInitialization() {
		for item in CardMaskItem.allCases {
			for suite in CardMaskSuite.allCases {
				let card = CardMaskModel(item: item, suite: suite)
				XCTAssertEqual(card.item, item)
				XCTAssertEqual(card.suite, suite)
			}
		}
	}

}
