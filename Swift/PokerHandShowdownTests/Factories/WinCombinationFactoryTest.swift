//
//  WinCombinationFactoryTest.swift
//  PokerHandShowdownTests
//
//  Created by Dzmitry Kudrashou on 2018-07-21.
//  Copyright © 2018 Dzmitry Kudrashou. All rights reserved.
//

import XCTest
@testable import PokerHandShowdown


///This test doesn't test WinCombination class, this test tests only the factory
class WinCombinationFactoryTest: XCTestCase {
	//will be used to check win combinations
	
	///support function
	func cardMasks(_ elements:(CardMaskItem, CardMaskSuite)...) -> [CardMask] {
		var returnValue:[CardMaskModel] = []
		for (item, mask) in elements {
			let cardMask = CardMaskModel.init(item: item, suite: mask)
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

	func testCreatingAllWinCombinations() {
		let equatable:(_ left:CardMask, _ right:CardMask) -> Bool = ({ $0.item == $1.item && $0.suite == $1.suite })
		let highCard 		= WinCombinationFactory.winCombination(for:.highCard)
		let onePair 		= WinCombinationFactory.winCombination(for:.onePair)
		let twoPair 		= WinCombinationFactory.winCombination(for:.twoPair)
		let treeOfAKind 	= WinCombinationFactory.winCombination(for:.treeOfAKind)
		let straight 		= WinCombinationFactory.winCombination(for:.straight)
		let flush 			= WinCombinationFactory.winCombination(for:.flush)
		let fullHouse		= WinCombinationFactory.winCombination(for:.fullHouse)
		let fourOfAKind 	= WinCombinationFactory.winCombination(for:.fourOfAKind)
		let straightFlush 	= WinCombinationFactory.winCombination(for:.straightFlush)
		let royalFlush 		= WinCombinationFactory.winCombination(for:.royalFlush)
		
		let highCardMask:[CardMask]			= self.cardMasks((.high, .any))
		let onePairMask:[CardMask]			= self.cardMasks((.any, .any), (.equal, .any))
		let twoPairMask:[CardMask]			= self.cardMasks((.any, .any), (.equal, .any), (.any, .any), (.equal, .any))
		let treeOfAKindMask:[CardMask]		= self.cardMasks((.any, .any), (.equal, .any), (.equal, .any))
		let straightMask:[CardMask]			= self.cardMasks((.any, .any), (.next, .any), (.next, .any), (.next, .any), (.next, .any))
		let flushMask:[CardMask]			= self.cardMasks((.any, .any), (.any, .equal), (.any, .equal), (.any, .equal), (.any, .equal))
		let fullHouseMask:[CardMask]		= self.cardMasks((.any, .any), (.equal, .any), (.equal, .any), (.any, .any), (.equal, .any))
		let fourOfAKindMask:[CardMask]		= self.cardMasks((.any, .any), (.equal, .any), (.equal, .any), (.equal, .any))
		let straightFlushMask:[CardMask]	= self.cardMasks((.any, .any), (.next, .equal), (.next, .equal), (.next, .equal), (.next, .equal))
		let royalFlushMask:[CardMask]		= self.cardMasks((.ten, .any), (.jack, .equal), (.queen, .equal), (.king, .equal), (.ace, .equal))
		
		XCTAssertEqual(highCard.winCombinationType, .highCard)
		XCTAssertEqual(onePair.winCombinationType, .onePair)
		XCTAssertEqual(twoPair.winCombinationType, .twoPair)
		XCTAssertEqual(treeOfAKind.winCombinationType, .treeOfAKind)
		XCTAssertEqual(straight.winCombinationType, .straight)
		XCTAssertEqual(flush.winCombinationType, .flush)
		XCTAssertEqual(fullHouse.winCombinationType, .fullHouse)
		XCTAssertEqual(fourOfAKind.winCombinationType, .fourOfAKind)
		XCTAssertEqual(straightFlush.winCombinationType, .straightFlush)
		XCTAssertEqual(royalFlush.winCombinationType, .royalFlush)
		
		XCTAssertLessThan(highCard.rating, onePair.rating)
		XCTAssertLessThan(onePair.rating, twoPair.rating)
		XCTAssertLessThan(twoPair.rating, treeOfAKind.rating)
		XCTAssertLessThan(treeOfAKind.rating, straight.rating)
		XCTAssertLessThan(straight.rating, flush.rating)
		XCTAssertLessThan(flush.rating, fullHouse.rating)
		XCTAssertLessThan(fullHouse.rating, fourOfAKind.rating)
		XCTAssertLessThan(fourOfAKind.rating, straightFlush.rating)
		XCTAssertLessThan(straightFlush.rating, royalFlush.rating)
		
		XCTAssertEqual(highCard.cardsMask.count, highCardMask.count)
		XCTAssertEqual(onePair.cardsMask.count, onePairMask.count)
		XCTAssertEqual(twoPair.cardsMask.count, twoPairMask.count)
		XCTAssertEqual(treeOfAKind.cardsMask.count, treeOfAKindMask.count)
		XCTAssertEqual(straight.cardsMask.count, straightMask.count)
		XCTAssertEqual(flush.cardsMask.count, flushMask.count)
		XCTAssertEqual(fullHouse.cardsMask.count, fullHouseMask.count)
		XCTAssertEqual(fourOfAKind.cardsMask.count, fourOfAKindMask.count)
		XCTAssertEqual(straightFlush.cardsMask.count, straightFlushMask.count)
		XCTAssertEqual(royalFlush.cardsMask.count, royalFlushMask.count)
		
		XCTAssertTrue(highCardMask.elementsEqual(highCard.cardsMask, by:equatable))
		XCTAssertTrue(onePairMask.elementsEqual(onePair.cardsMask, by:equatable))
		XCTAssertTrue(twoPairMask.elementsEqual(twoPair.cardsMask, by:equatable))
		XCTAssertTrue(treeOfAKindMask.elementsEqual(treeOfAKind.cardsMask, by:equatable))
		XCTAssertTrue(straightMask.elementsEqual(straight.cardsMask, by:equatable))
		XCTAssertTrue(flushMask.elementsEqual(flush.cardsMask, by:equatable))
		XCTAssertTrue(fullHouseMask.elementsEqual(fullHouse.cardsMask, by:equatable))
		XCTAssertTrue(fourOfAKindMask.elementsEqual(fourOfAKind.cardsMask, by:equatable))
		XCTAssertTrue(straightFlushMask.elementsEqual(straightFlush.cardsMask, by:equatable))
		XCTAssertTrue(royalFlushMask.elementsEqual(royalFlush.cardsMask, by:equatable))
	}
}
