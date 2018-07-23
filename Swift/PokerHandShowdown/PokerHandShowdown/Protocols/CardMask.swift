//
//  CardMask.swift
//  PokerHandShowdown
//
//  Created by Dzmitry Kudrashou on 2018-07-21.
//  Copyright © 2018 Dzmitry Kudrashou. All rights reserved.
//

//MARK: - Enumerations
public enum CardMaskItem : CaseIterable {
	case two
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
	
	case any
	case equal
	case high
	case next
	
	@available(swift, obsoleted: 4.2)
	static let allCases: [CardMaskItem] = [any, equal, high, next, ace, king, queen, jack, ten, nine, eight, seven, six, five, four, three, two]
}

public enum CardMaskSuite : CaseIterable {
	case any
	case equal
	
	@available(swift, obsoleted: 4.2)
	static let allCases: [CardMaskSuite] = [any, equal]
}

//MARK: - Protocol
public protocol CardMask {
	var suite:CardMaskSuite { get }
	var item:CardMaskItem { get }
}
