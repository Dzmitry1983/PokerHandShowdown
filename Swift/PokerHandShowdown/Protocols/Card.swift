//
//  Card.swift
//  PokerHandShowdown
//
//  Created by Dzmitry Kudrashou on 2018-07-21.
//  Copyright © 2018 Dzmitry Kudrashou. All rights reserved.
//


//MARK: - Enumerations
public enum CardItem : Int, CaseIterable {
	case two = 2
	case three
	case four
	case five
	case six
	case seven
	case eight
	case nine
	case ten
	case jack
	case queen
	case king
	case ace
	
	@available(swift, obsoleted: 4.2)
	static let allCases: [CardItem] = [ace, king, queen, jack, ten, nine, eight, seven, six, five, four, three, two]
}

public enum CardSuite : CaseIterable {
	case club
	case diamond
	case heart
	case spade
	
	@available(swift, obsoleted: 4.2)
	static let allCases: [CardSuite] = [club, diamond, heart, spade]
}

//MARK: - Protocol
///Use this protocol to create custom cards classes
public protocol Card {
	var item:CardItem { get }
	var suite:CardSuite { get }
	var rating:Int { get }
}
