//
//  Hand.swift
//  PokerHandShowdown
//
//  Created by Dzmitry Kudrashou on 2018-07-21.
//  Copyright © 2018 Dzmitry Kudrashou. All rights reserved.
//

///Use this protocol to create custom players' classes
public protocol Hand {
	var cards:[Card] {get}
}
