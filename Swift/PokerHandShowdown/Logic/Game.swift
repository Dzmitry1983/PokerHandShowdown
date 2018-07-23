//
//  Game.swift
//  PokerHandShowdown
//
//  Created by Dzmitry Kudrashou on 2018-07-21.
//  Copyright © 2018 Dzmitry Kudrashou. All rights reserved.
//

///Class Game evaluates hands and searchs the winners
public class Game {
	//MARK: - Type cosntant properties
	private static let reducedWinCombinationsType:[WinCombinationType] = [
		WinCombinationType.flush,
		WinCombinationType.treeOfAKind,
		WinCombinationType.onePair,
		WinCombinationType.highCard,
	]
	
	//MARK: - Stored properties
	private(set) var winCombinations:[WinCombination] = []
	
	//MARK: - initializations
	///isFullGame = false means that will be loaded only these combinations:
	///• Flush
	///• Three of a Kind
	///• One Pair
	///• High Card
	/// if you want to load all combinations, set isFullGame = true
	public init(_ isFullGame:Bool = false) {
		if isFullGame {
			self.winCombinations = self.loadAllWinCombinations()
		}
		else {
			self.winCombinations = self.loadReducedWinCombinations()
		}
	}
	
	//MARK: - private methoods
	private func loadAllWinCombinations() -> [WinCombination] {
		return WinCombinationType.allCases.map { WinCombinationFactory.winCombination(for:$0) }.sorted(by: { $0.rating > $1.rating })
	}
	
	private func loadReducedWinCombinations() -> [WinCombination] {
		return Game.reducedWinCombinationsType.map{ WinCombinationFactory.winCombination(for:$0) }.sorted(by: { $0.rating > $1.rating })
	}
	
	private func winCombination(for hand:Hand) -> WinCombination? {
		for winCombination in self.winCombinations {
			if winCombination.isWin(hand) {
				return winCombination
			}
		}
		return nil
	}
	
	private func winCombinationsRatings<Type:Hand>(for hands:[Type]) -> [(hand:Type, rating:WinCombination.WinCombinationRating)] {
		var returnValue:[(Type, WinCombination.WinCombinationRating)] = []
		for hand in hands {
			if let winCombination = self.winCombination(for:hand) {
				returnValue.append((hand, winCombination.rating(hand)))
			}
			else {
				returnValue.append((hand, WinCombination.WinCombinationRating()))
			}
		}
		return returnValue
	}
	
	//MARK: - public methods
	public func winners<Type:Hand>(from hands:[Type]) -> [Type] {
		var winners:[Type] = []
		let preWinners = self.winCombinationsRatings(for:hands)
		if let winner = preWinners.max(by: { $0.rating < $1.rating }) {
			let sorted = preWinners.filter({ $0.rating == winner.rating })
			winners = sorted.map({ $0.hand })
		}
		return winners
	}
}
