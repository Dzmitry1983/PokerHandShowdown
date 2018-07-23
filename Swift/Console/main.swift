//
//  main.swift
//  Console
//
//  Created by Dzmitry Kudrashou on 2018-07-21.
//  Copyright © 2018 Dzmitry Kudrashou. All rights reserved.
//

///This file is used only for a console target
///and it shows a way to use PokerHandShowdown framework


import Foundation
import PokerHandShowdown


//MARK: - examples to use framework
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

printPreGame(playersOne)
printWinners(firstWinners)
printPreGame(playersTwo)
printWinners(secondWinners)
printPreGame(playersThree)
printWinners(thirstWinners)
printPreGame(playersFour)
printWinners(fourstWinners)


//MARK: - support functions
func cardToString(_ card:Card) -> String {
	let suite:String
	let item:String
	switch card.item {
	case .two:
		item = "2"
	case .three:
		item = "3"
	case .four:
		item = "4"
	case .five:
		item = "5"
	case .six:
		item = "6"
	case .seven:
		item = "7"
	case .eight:
		item = "8"
	case .nine:
		item = "9"
	case .ten:
		item = "10"
	case .jack:
		item = "J"
	case .queen:
		item = "Q"
	case .king:
		item = "K"
	case .ace:
		item = "A"
	}
	
	switch card.suite {
	case .club:
		suite = "C"
	case .diamond:
		suite = "D"
	case .spade:
		suite = "S"
	case .heart:
		suite = "H"
	}
	
	return item + suite
}


func printPreGame(_ players:[Player]) {
	for player in players {
		print("\(player.name)")
		print(player.cards.map { cardToString($0) }.joined(separator:", "))
	}
}

func printWinners(_ players:[Player]) {
	for player in players {
		print("\n")
		print("\(player.name) wins")
		print("\n")
	}
}


