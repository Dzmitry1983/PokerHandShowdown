# PokerHandShowdown
A framework finds winners for a poker game

# Requirements
swift version = 4.1
Xcode 9.4.1

# Usage
```swift
let game = Game.init(true)
let players = [
	PlayerFactory.player(name:"Joe", cards:"2H", "3D", "4C", "5D", "10H")!,
	PlayerFactory.player(name:"Jen", cards:"5C", "7D", "8H", "9S", "QD")!,
	PlayerFactory.player(name:"Bob", cards:"2C", "4D", "5S", "10C", "JH")!,
]
let winners = game.winners(from:players)
//to print winners
firstWinners.forEach{ print($0.name) }
```

# Examples
An example can be seen in the main.swift
To run an example, use "Console" target

# Tests
To use tests, chose the PokerHandShowdown target and run test.

# Architecture
Use this images to help understand an architecture
![alt text](https://github.com/Dzmitry1983/PokerHandShowdown/blob/master/Architecture/Class%20Diagram.png "Class Diagram")
![alt text](https://github.com/Dzmitry1983/PokerHandShowdown/blob/master/Architecture/Activity%20Diagram.png "Activity Diagram")
