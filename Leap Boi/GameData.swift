//
//  GameData.swift
//  Leap Boi
//
//  Created by Robert Desjardins on 2018-02-28.
//  Copyright © 2018 Robert Desjardins. All rights reserved.
//

import Foundation

class GameData {
    static let shared = GameData()
    var maxPlayerHealth = 0
    var playerHealth = 0
    var numberOfHealthUpgrades = 0
    var playerScore = 0
    var playerHighScore: [Int] = []
    var weaponChosen = "laser"
    var shieldAmount = 500
    var shieldTime: TimeInterval = 10
    var creditsEarned: Int = 0
    var totalCredits: Int = 0
    
    
    private init() { }
}
