//
//  GameTest.swift
//  PokerHandShowdownTests
//
//  Created by Dzmitry Kudrashou on 2018-07-21.
//  Copyright © 2018 Dzmitry Kudrashou. All rights reserved.
//

import XCTest
@testable import PokerHandShowdown

class GameTest: XCTestCase {
	
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

	func testInitialization() {
		let gameFull = Game.init(true)
		let gameReduced = Game.init(false)
		XCTAssertEqual(gameFull.winCombinations.count, 10)
		XCTAssertEqual(gameReduced.winCombinations.count, 4)
	}
	
	func testHighestCard() {
		let gameFull = Game.init(true)
		let gameReduced = Game.init(false)
		let playersOne = [
			PlayerFactory.player(name:"Joe", cards:"AS", "KD", "2H", "3S", "5H")!,
			PlayerFactory.player(name:"Mike", cards:"AS", "KD",  "2H", "3S", "5D")!,
			PlayerFactory.player(name:"Dan", cards:"AS", "QD", "2H", "3S", "5H")!,
		]
		
		let playersTwo = [
			PlayerFactory.player(name:"Joe", cards:"AS", "KD", "2H", "3S", "5H")!,
			PlayerFactory.player(name:"Mike", cards:"AS", "KD",  "2H", "3S", "4H")!,
			PlayerFactory.player(name:"Dan", cards:"AS", "QD", "2H", "3S", "5H")!,
			]
		
		let firstFullWinners = gameFull.winners(from:playersOne)
		let firstReducedWinners = gameReduced.winners(from:playersOne)
		let secondFullWinners = gameFull.winners(from:playersTwo)
		let secondReducedWinners = gameReduced.winners(from:playersTwo)
		
		XCTAssertEqual(firstFullWinners.count, 2)
		XCTAssertEqual(firstReducedWinners.count, 2)
		
		XCTAssertEqual(secondFullWinners.count, 1)
		XCTAssertEqual(secondReducedWinners.count, 1)
		
		XCTAssertTrue(firstFullWinners.contains { $0.name == "Joe" })
		XCTAssertTrue(firstFullWinners.contains { $0.name == "Mike" })
		
		XCTAssertTrue(firstReducedWinners.contains { $0.name == "Joe" })
		XCTAssertTrue(firstReducedWinners.contains { $0.name == "Mike" })
		
		XCTAssertTrue(secondFullWinners.contains { $0.name == "Joe" })
		XCTAssertTrue(secondReducedWinners.contains { $0.name == "Joe" })
		
	}
	
	func testOnePair() {
		let gameFull = Game.init(true)
		let gameReduced = Game.init(false)
		let playersOne = [
			PlayerFactory.player(name:"Joe", cards:"AS", "AD", "2H", "3S", "5H")!,
			PlayerFactory.player(name:"Mike", cards:"AS", "AD", "2H", "3S", "5H")!,
			PlayerFactory.player(name:"Dan", cards:"AS", "QD", "QH", "3S", "5H")!,
			]
		
		let playersTwo = [
			PlayerFactory.player(name:"Joe", cards:"AS", "KD", "2H", "2S", "5H")!,
			PlayerFactory.player(name:"Mike", cards:"AS", "KD",  "2H", "3S", "4H")!,
			PlayerFactory.player(name:"Dan", cards:"AS", "QD", "2H", "3S", "5H")!,
			]
		
		let firstFullWinners = gameFull.winners(from:playersOne)
		let firstReducedWinners = gameReduced.winners(from:playersOne)
		let secondFullWinners = gameFull.winners(from:playersTwo)
		let secondReducedWinners = gameReduced.winners(from:playersTwo)
		
		XCTAssertEqual(firstFullWinners.count, 2)
		XCTAssertEqual(firstReducedWinners.count, 2)
		
		XCTAssertEqual(secondFullWinners.count, 1)
		XCTAssertEqual(secondReducedWinners.count, 1)
		
		XCTAssertTrue(firstFullWinners.contains { $0.name == "Joe" })
		XCTAssertTrue(firstFullWinners.contains { $0.name == "Mike" })
		
		XCTAssertTrue(firstReducedWinners.contains { $0.name == "Joe" })
		XCTAssertTrue(firstReducedWinners.contains { $0.name == "Mike" })
		
		XCTAssertTrue(secondFullWinners.contains { $0.name == "Joe" })
		XCTAssertTrue(secondReducedWinners.contains { $0.name == "Joe" })
	}
	
	func testTwoPair() {
		let gameFull = Game.init(true)
		let playersOne = [
			PlayerFactory.player(name:"Joe", cards:"KS", "KD", "2H", "3S", "3H")!,
			PlayerFactory.player(name:"Mike", cards:"KS", "KD", "2H", "3S", "3H")!,
			PlayerFactory.player(name:"Dan", cards:"KS", "KD", "2H", "3S", "5H")!,
			]
		
		let playersTwo = [
			PlayerFactory.player(name:"Joe", cards:"KS", "KD", "2H", "3S", "3H")!,
			PlayerFactory.player(name:"Mike", cards:"QS", "QD", "2H", "4S", "4H")!,
			PlayerFactory.player(name:"Dan", cards:"AS", "QD", "2H", "3S", "5H")!,
			]
		
		let firstFullWinners = gameFull.winners(from:playersOne)
		let secondFullWinners = gameFull.winners(from:playersTwo)
		
		XCTAssertEqual(firstFullWinners.count, 2)
		
		XCTAssertEqual(secondFullWinners.count, 1)
		
		XCTAssertTrue(firstFullWinners.contains { $0.name == "Joe" })
		XCTAssertTrue(firstFullWinners.contains { $0.name == "Mike" })
		
		XCTAssertTrue(secondFullWinners.contains { $0.name == "Joe" })
	}
	
	func testTreeOfAKind() {
		let gameFull = Game.init(true)
		let gameReduced = Game.init(false)
		let playersOne = [
			PlayerFactory.player(name:"Joe", cards:"AS", "AD", "AH", "3S", "5H")!,
			PlayerFactory.player(name:"Mike", cards:"AS", "AD", "AH", "3S", "5H")!,
			PlayerFactory.player(name:"Dan", cards:"AS", "AD", "QH", "3S", "3H")!,
			]
		
		let playersTwo = [
			PlayerFactory.player(name:"Joe", cards:"AS", "AD", "AH", "3S", "5H")!,
			PlayerFactory.player(name:"Mike", cards:"AS", "AD", "AH", "3S", "4H")!,
			PlayerFactory.player(name:"Dan", cards:"QS", "QD", "QH", "10S", "JH")!,
			]
		
		let firstFullWinners = gameFull.winners(from:playersOne)
		let firstReducedWinners = gameReduced.winners(from:playersOne)
		let secondFullWinners = gameFull.winners(from:playersTwo)
		let secondReducedWinners = gameReduced.winners(from:playersTwo)
		
		XCTAssertEqual(firstFullWinners.count, 2)
		XCTAssertEqual(firstReducedWinners.count, 2)
		
		XCTAssertEqual(secondFullWinners.count, 1)
		XCTAssertEqual(secondReducedWinners.count, 1)
		
		XCTAssertTrue(firstFullWinners.contains { $0.name == "Joe" })
		XCTAssertTrue(firstFullWinners.contains { $0.name == "Mike" })
		
		XCTAssertTrue(firstReducedWinners.contains { $0.name == "Joe" })
		XCTAssertTrue(firstReducedWinners.contains { $0.name == "Mike" })
		
		XCTAssertTrue(secondFullWinners.contains { $0.name == "Joe" })
		XCTAssertTrue(secondReducedWinners.contains { $0.name == "Joe" })
	}
	
	func testStraight() {
		let gameFull = Game.init(true)
		let playersOne = [
			PlayerFactory.player(name:"Joe", cards:"3S", "4D", "5H", "6S", "7H")!,
			PlayerFactory.player(name:"Mike", cards:"3S", "4D", "5D", "6S", "7H")!,
			PlayerFactory.player(name:"Dan", cards:"AS", "AD", "AH", "3S", "5H")!,
			]
		
		let playersTwo = [
			PlayerFactory.player(name:"Joe", cards:"8S", "4D", "5H", "6S", "7H")!,
			PlayerFactory.player(name:"Mike", cards:"3S", "4D", "5D", "6S", "7H")!,
			PlayerFactory.player(name:"Dan", cards:"AS", "AD", "AH", "3S", "5H")!,
			]
		
		let firstFullWinners = gameFull.winners(from:playersOne)
		let secondFullWinners = gameFull.winners(from:playersTwo)
		
		XCTAssertEqual(firstFullWinners.count, 2)
		
		XCTAssertEqual(secondFullWinners.count, 1)
		
		XCTAssertTrue(firstFullWinners.contains { $0.name == "Joe" })
		XCTAssertTrue(firstFullWinners.contains { $0.name == "Mike" })
		
		XCTAssertTrue(secondFullWinners.contains { $0.name == "Joe" })
	}
	
	func testFlush() {
		let gameFull = Game.init(true)
		let gameReduced = Game.init(false)
		let playersOne = [
			PlayerFactory.player(name:"Joe", cards:"3S", "4S", "10S", "6S", "7S")!,
			PlayerFactory.player(name:"Mike", cards:"3S", "4S", "10S", "6S", "7S")!,
			PlayerFactory.player(name:"Dan", cards:"8S", "4D", "5H", "6S", "7H")!,
			]
		
		let playersTwo = [
			PlayerFactory.player(name:"Joe", cards:"3S", "4S", "10S", "6S", "7S")!,
			PlayerFactory.player(name:"Mike", cards:"3S", "4S", "10S", "5S", "7S")!,
			PlayerFactory.player(name:"Dan", cards:"8S", "4D", "5H", "6S", "7H")!,
			]
		
		let firstFullWinners = gameFull.winners(from:playersOne)
		let firstReducedWinners = gameReduced.winners(from:playersOne)
		let secondFullWinners = gameFull.winners(from:playersTwo)
		let secondReducedWinners = gameReduced.winners(from:playersTwo)
		
		XCTAssertEqual(firstFullWinners.count, 2)
		XCTAssertEqual(firstReducedWinners.count, 2)
		
		XCTAssertEqual(secondFullWinners.count, 1)
		XCTAssertEqual(secondReducedWinners.count, 1)
		
		XCTAssertTrue(firstFullWinners.contains { $0.name == "Joe" })
		XCTAssertTrue(firstFullWinners.contains { $0.name == "Mike" })
		
		XCTAssertTrue(firstReducedWinners.contains { $0.name == "Joe" })
		XCTAssertTrue(firstReducedWinners.contains { $0.name == "Mike" })
		
		XCTAssertTrue(secondFullWinners.contains { $0.name == "Joe" })
		XCTAssertTrue(secondReducedWinners.contains { $0.name == "Joe" })
	}
	
	func testFullHouse() {
		let gameFull = Game.init(true)
		let playersOne = [
			PlayerFactory.player(name:"Joe", cards:"8S", "8D", "8H", "2S", "2H")!,
			PlayerFactory.player(name:"Mike", cards:"8S", "8D", "8H", "2S", "2H")!,
			PlayerFactory.player(name:"Dan", cards:"3S", "4S", "10S", "6S", "7S")!,
			]
		
		let playersTwo = [
			PlayerFactory.player(name:"Joe", cards:"8S", "8D", "8H", "3S", "3H")!,
			PlayerFactory.player(name:"Mike", cards:"8S", "8D", "8H", "2S", "2H")!,
			PlayerFactory.player(name:"Dan", cards:"7S", "7D", "7H", "AS", "AH")!,
			]
		
		let firstFullWinners = gameFull.winners(from:playersOne)
		let secondFullWinners = gameFull.winners(from:playersTwo)
		
		XCTAssertEqual(firstFullWinners.count, 2)
		
		XCTAssertEqual(secondFullWinners.count, 1)
		
		XCTAssertTrue(firstFullWinners.contains { $0.name == "Joe" })
		XCTAssertTrue(firstFullWinners.contains { $0.name == "Mike" })
		
		XCTAssertTrue(secondFullWinners.contains { $0.name == "Joe" })
	}
	
	func testFourOfAKind() {
		let gameFull = Game.init(true)
		let playersOne = [
			PlayerFactory.player(name:"Joe", cards:"8S", "8D", "8H", "8S", "2H")!,
			PlayerFactory.player(name:"Mike", cards:"8S", "8D", "8H", "8S", "2H")!,
			PlayerFactory.player(name:"Dan", cards:"9S", "9D", "9H", "3S", "3H")!,
			]
		
		let playersTwo = [
			PlayerFactory.player(name:"Joe", cards:"8S", "8D", "8H", "8S", "3H")!,
			PlayerFactory.player(name:"Mike", cards:"8S", "8D", "8H", "8S", "2H")!,
			PlayerFactory.player(name:"Dan", cards:"7S", "7D", "7H", "7S", "AH")!,
			]
		
		let firstFullWinners = gameFull.winners(from:playersOne)
		let secondFullWinners = gameFull.winners(from:playersTwo)
		
		XCTAssertEqual(firstFullWinners.count, 2)
		
		XCTAssertEqual(secondFullWinners.count, 1)
		
		XCTAssertTrue(firstFullWinners.contains { $0.name == "Joe" })
		XCTAssertTrue(firstFullWinners.contains { $0.name == "Mike" })
		
		XCTAssertTrue(secondFullWinners.contains { $0.name == "Joe" })
	}
	
	func testStraightFlush() {
		let gameFull = Game.init(true)
		let gameReduced = Game.init(false)
		let playersOne = [
			PlayerFactory.player(name:"Joe", cards:"KH", "QH", "JH", "10H", "9H")!,
			PlayerFactory.player(name:"Mike", cards:"KH", "QH", "JH", "10H", "9H")!,
			PlayerFactory.player(name:"Dan", cards:"8S", "8D", "8H", "8S", "3H")!,
			]
		
		let playersTwo = [
			PlayerFactory.player(name:"Joe", cards:"KH", "QH", "JH", "10H", "9H")!,
			PlayerFactory.player(name:"Mike", cards:"8H", "QH", "JH", "10H", "9H")!,
			PlayerFactory.player(name:"Dan", cards:"8S", "8D", "8H", "8S", "3H")!,
			]
		
		let firstFullWinners = gameFull.winners(from:playersOne)
		let firstReducedWinners = gameReduced.winners(from:playersOne)
		let secondFullWinners = gameFull.winners(from:playersTwo)
		let secondReducedWinners = gameReduced.winners(from:playersTwo)
		
		XCTAssertEqual(firstFullWinners.count, 2)
		XCTAssertEqual(firstReducedWinners.count, 2)
		
		XCTAssertEqual(secondFullWinners.count, 1)
		XCTAssertEqual(secondReducedWinners.count, 1)
		
		XCTAssertTrue(firstFullWinners.contains { $0.name == "Joe" })
		XCTAssertTrue(firstFullWinners.contains { $0.name == "Mike" })
		
		XCTAssertTrue(firstReducedWinners.contains { $0.name == "Joe" })
		XCTAssertTrue(firstReducedWinners.contains { $0.name == "Mike" })
		
		XCTAssertTrue(secondFullWinners.contains { $0.name == "Joe" })
		XCTAssertTrue(secondReducedWinners.contains { $0.name == "Joe" })
	}
	
	func testRoyalFlush() {
		let gameFull = Game.init(true)
		let playersOne = [
			PlayerFactory.player(name:"Joe", cards:"KH", "QH", "JH", "10H", "AH")!,
			PlayerFactory.player(name:"Mike", cards:"KH", "QH", "JH", "10H", "AH")!,
			PlayerFactory.player(name:"Dan", cards:"KH", "QH", "JH", "10H", "9H")!,
			]
		
		let playersTwo = [
			PlayerFactory.player(name:"Joe", cards:"KH", "QH", "JH", "10H", "AH")!,
			PlayerFactory.player(name:"Mike", cards:"KH", "QH", "JH", "10H", "9H")!,
			PlayerFactory.player(name:"Dan", cards:"KH", "QH", "JH", "10H", "9H")!,
			]
		
		let firstFullWinners = gameFull.winners(from:playersOne)
		let secondFullWinners = gameFull.winners(from:playersTwo)
		
		XCTAssertEqual(firstFullWinners.count, 2)
		
		XCTAssertEqual(secondFullWinners.count, 1)
		
		XCTAssertTrue(firstFullWinners.contains { $0.name == "Joe" })
		XCTAssertTrue(firstFullWinners.contains { $0.name == "Mike" })
	
		XCTAssertTrue(secondFullWinners.contains { $0.name == "Joe" })
	}
	
	func testFinalTest() {
		let playersOne = [
			PlayerFactory.player(name:"Joe", cards:"8S", "8D", "AD", "QD", "JH")!,
			PlayerFactory.player(name:"Bob", cards:"AS", "QS", "8S", "6S", "4S")!,
			PlayerFactory.player(name:"Sally", cards:"4S", "4H", "3H", "QC", "8C")!,
			]
		
		let playersTwo = [
			PlayerFactory.player(name:"Joe", cards:"QD", "8D", "KD", "7D", "3D")!,
			PlayerFactory.player(name:"Bob", cards:"AS", "QS", "8S", "6S", "4S")!,
			PlayerFactory.player(name:"Sally", cards:"4S", "4H", "3H", "QC", "8C")!,
			]
		
		let playersThree = [
			PlayerFactory.player(name:"Joe", cards:"3H", "5D", "9C", "9D", "QH")!,
			PlayerFactory.player(name:"Jen", cards:"5C", "7D", "9H", "9S", "QS")!,
			PlayerFactory.player(name:"Bob", cards:"2H", "2C", "5S", "10C", "AH")!,
			]
		
		let playersFour = [
			PlayerFactory.player(name:"Joe", cards:"2H", "3D", "4C", "5D", "10H")!,
			PlayerFactory.player(name:"Jen", cards:"5C", "7D", "8H", "9S", "QD")!,
			PlayerFactory.player(name:"Bob", cards:"2C", "4D", "5S", "10C", "JH")!,
			]
		
		let gameReduced = Game.init(false)
		let firstWinners = gameReduced.winners(from:playersOne)
		let secondWinners = gameReduced.winners(from:playersTwo)
		let thirstWinners = gameReduced.winners(from:playersThree)
		let fourstWinners = gameReduced.winners(from:playersFour)
		
		XCTAssertEqual(firstWinners.count, 1)
		XCTAssertTrue(firstWinners.contains { $0.name == "Bob" })
		
		XCTAssertEqual(secondWinners.count, 1)
		XCTAssertTrue(secondWinners.contains { $0.name == "Bob" })
		
		XCTAssertEqual(thirstWinners.count, 1)
		XCTAssertTrue(thirstWinners.contains { $0.name == "Jen" })
		
		XCTAssertEqual(fourstWinners.count, 1)
		XCTAssertTrue(fourstWinners.contains { $0.name == "Jen" })
	}
	
}
