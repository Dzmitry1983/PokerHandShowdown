//
//  CaseIterable.swift
//  PokerHandShowdown
//
//  Created by Dzmitry Kudrashou on 2018-07-22.
//  Copyright © 2018 Dzmitry Kudrashou. All rights reserved.
//


///If current swift version >= 4.2 this protocol need to be removed becouse apple add their protocol
@available(swift, obsoleted: 4.2)
protocol CaseIterable {
	static var allCases:[Self] { get }
}

