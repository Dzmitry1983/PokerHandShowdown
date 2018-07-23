//
//  PlayerTest.swift
//  PokerHandShowdownTests
//
//  Created by Dzmitry Kudrashou on 2018-07-22.
//  Copyright © 2018 Dzmitry Kudrashou. All rights reserved.
//

import XCTest
@testable import PokerHandShowdown

class PlayerTest: XCTestCase {

    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

	///check the situations when Player isn't created
    func testFailInitialisation() {
		let players:[(String, [String])] = [
			("", ["8S", "8D", "AD", "QD", "JH"]), 				//empty name
			("Bob", ["QS", "8S", "6S", "4S"]), 					//4 cards
			("Sally", ["4S", "4H", "3H", "QC", "8C", "8C"]),	//6 cards
			("Joe", ["QD", "8D", "KD"]),						//3 cards
			("Bob", ["AS", "QS"]),								//2 cards
			("Sally", ["4S"]),									// 1 card
			("Joe", []),										// zero cards
			]
		
		
		
		for (name, cardCodes) in players {
			let cards = CardModelFactory.cards(cardCodes)
			XCTAssertEqual(cards.count, cardCodes.count)
			XCTAssertNil(Player.init(name: name, cards: cards))
		}
    }
	
	///check the situations when Player is created
	func testPassInitialisation() {
		let players:[(String, [String])] = [
			("Joe", ["8S", "8D", "AD", "QD", "JH"]),
			("Bob", ["AS", "QS", "8S", "6S", "4S"]),
			("Sally", ["4S", "4H", "3H", "QC", "8C"]),
			("Joe", ["QD", "8D", "KD", "7D", "3D"]),
			("Bob", ["AS", "QS", "8S", "6S", "4S"]),
			("Sally", ["4S", "4H", "3H", "QC", "8C"]),
			("Joe", ["3H", "5D", "9C", "9D", "QH"]),
			("Jen", ["5C", "7D", "9H", "9S", "QS"]),
			("Bob", ["2H", "2C", "5S", "10C", "AH"]),
			("Joe", ["2H", "3D", "4C", "5D", "10H"]),
			("Jen", ["5C", "7D", "8H", "9S", "QD"]),
		]
		
		for (name, cardCodes) in players {
			let cards = CardModelFactory.cards(cardCodes)
			XCTAssertEqual(cards.count, cardCodes.count)
			if let player = Player.init(name: name, cards: cards) {
				XCTAssert(player.cards.elementsEqual(cards, by: { $0.item == $1.item && $0.suite == $1.suite}))
				XCTAssertEqual(player.name, name)
			}
			else {
				XCTAssert(false, "Player doesn't to be nil")
			}
		}
	}

	
	
	
}
