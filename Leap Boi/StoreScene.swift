//
//  StoreScene.swift
//  Leap Boi
//
//  Created by Robert Desjardins on 2018-03-09.
//  Copyright © 2018 Robert Desjardins. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion


class StoreScene: SKScene {
    let background = SKSpriteNode(imageNamed: "starbackground")
    var backButton: SKSpriteNode! = nil
    var healthUpgradeButton: SKSpriteNode! = nil
    var shieldHealthUpgradeButton: SKSpriteNode! = nil
    var shieldDurationUpgradeButton: SKSpriteNode! = nil
    var creditsLabel: SKLabelNode! = nil
    
    override func didMove(to view: SKView) {
        scene?.scaleMode = .aspectFit
        createBackground()
        createUI()
    }

    func createBackground() {
        let background = SKSpriteNode(imageNamed: "starbackground")
        background.zPosition = 1
        background.size = CGSize(width: background.size.width, height: frame.size.height)
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        addChild(background)
    }
    
    func createUI() {
        let upgradeButtonWidth = size.width - 30
        let upgradeButtonHeight = upgradeButtonWidth * 0.1557496361
        createBackButton()
        createHealthUpgradeButton(width: upgradeButtonWidth, height: upgradeButtonHeight)
        createShieldHealthUpgradeButton(width: upgradeButtonWidth, height: upgradeButtonHeight)
        createShieldDurationUpgradeButton(width: upgradeButtonWidth, height: upgradeButtonHeight)
        createCreditsLabel()
    }
    
    func createBackButton() {
        backButton = SKSpriteNode(imageNamed: "back")
        backButton.zPosition = 2
        backButton.size = CGSize(width: 64, height: 64)
        backButton.position = CGPoint(x: backButton.frame.size.width / 2 + 20, y: backButton.frame.size.height / 2 + 20)
        addChild(backButton)
    }
    
    func createCreditsLabel() {
        creditsLabel = SKLabelNode(fontNamed: "Avenir")
        creditsLabel.zPosition = 2
        creditsLabel.fontSize = 25
        creditsLabel.fontColor = SKColor.white
        creditsLabel.text = "Credits: \(GameData.shared.totalCredits)"
        creditsLabel.position = CGPoint(x: size.width/2, y: size.height - 40)
        self.addChild(creditsLabel)
    }
    
    func createHealthUpgradeButton(width: CGFloat, height: CGFloat) {
        healthUpgradeButton = SKSpriteNode(imageNamed: "button_increase_max_hp")
        healthUpgradeButton.zPosition = 2
        healthUpgradeButton.size = CGSize(width: width, height: height)
        healthUpgradeButton.position = CGPoint(x: size.width / 2, y: size.height * (5/6))
        addChild(healthUpgradeButton)
    }
    
    func createShieldHealthUpgradeButton(width: CGFloat, height: CGFloat) {
        shieldHealthUpgradeButton = SKSpriteNode(imageNamed: "button_increase_shield_amount")
        shieldHealthUpgradeButton.zPosition = 2
        shieldHealthUpgradeButton.size = CGSize(width: width, height: height)
        shieldHealthUpgradeButton.position = healthUpgradeButton.position - CGPoint(x: 0, y: healthUpgradeButton.size.height + 25)
        addChild(shieldHealthUpgradeButton)
    }
    
    func createShieldDurationUpgradeButton(width: CGFloat, height: CGFloat) {
        shieldDurationUpgradeButton = SKSpriteNode(imageNamed: "button_increase_shield_duration")
        shieldDurationUpgradeButton.zPosition = 2
        shieldDurationUpgradeButton.size = CGSize(width: width, height: height)
        shieldDurationUpgradeButton.position = shieldHealthUpgradeButton.position - CGPoint(x: 0, y: shieldHealthUpgradeButton.size.height + 25)
        addChild(shieldDurationUpgradeButton)
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first
        let touchLocation = touch!.location(in: self)
        if backButton.contains(touchLocation) {
            startSceneLoad(view: view!)
        }
        if healthUpgradeButton.contains(touchLocation) {
            let costToUpgrade = 1000 + GameData.shared.numberOfHealthUpgrades * 1000
            let alert = UIAlertController(title: "Upgrade Max HP by 50?", message: "Credits: \(costToUpgrade)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "No", style: .default, handler: { _ in
                NSLog("The \"NO\" alert occured.")
            }))
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
                NSLog("The \"Yes\" alert occured.")
                if GameData.shared.totalCredits < costToUpgrade {
                    let notEnoughCreditsAlert = UIAlertController(title: "Not Enough Credits", message: "Credits are earned by playing or can be purchased", preferredStyle: .alert)
                    notEnoughCreditsAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.view?.window?.rootViewController?.present(notEnoughCreditsAlert, animated: true, completion: nil)
                } else {
                    GameData.shared.totalCredits = GameData.shared.totalCredits - costToUpgrade
                    GameData.shared.numberOfHealthUpgrades = GameData.shared.numberOfHealthUpgrades + 1
                    UserDefaults.standard.setUserHealthUpgrades(numberOfHealthUpgrades: GameData.shared.numberOfHealthUpgrades)
                    UserDefaults.standard.setUserCredits(credits: GameData.shared.totalCredits)
                    self.creditsLabel.text = "Credits: \(GameData.shared.totalCredits)"
                    let newHealth = 100 + 50 * UserDefaults.standard.getUserHealthUpgrades()
                    let purchaseAlert = UIAlertController(title: "HP increased to \(newHealth)!", message: "Remaining Credit Balance: \(GameData.shared.totalCredits)", preferredStyle: .alert)
                    purchaseAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.view?.window?.rootViewController?.present(purchaseAlert, animated: true, completion: nil)
                }
            }))
            self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
        }
        if shieldHealthUpgradeButton.contains(touchLocation) {
            let costToUpgrade = 1000 + GameData.shared.numberOfShieldHealthUpgrades * 1000
            let alert = UIAlertController(title: "Increase shield by 50?", message: "Credits: \(costToUpgrade)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "No", style: .default, handler: { _ in
                NSLog("The \"NO\" alert occured.")
            }))
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
                NSLog("The \"Yes\" alert occured.")
                if GameData.shared.totalCredits < costToUpgrade {
                    let notEnoughCreditsAlert = UIAlertController(title: "Not Enough Credits", message: "Credits are earned by playing or can be purchased", preferredStyle: .alert)
                    notEnoughCreditsAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.view?.window?.rootViewController?.present(notEnoughCreditsAlert, animated: true, completion: nil)
                } else {
                    GameData.shared.totalCredits = GameData.shared.totalCredits - costToUpgrade
                    GameData.shared.numberOfShieldHealthUpgrades = GameData.shared.numberOfShieldHealthUpgrades + 1
                    UserDefaults.standard.setUserShieldHealthUpgrades(numberOfShieldHealthUpgrades: GameData.shared.numberOfShieldHealthUpgrades)
                    UserDefaults.standard.setUserCredits(credits: GameData.shared.totalCredits)
                    self.creditsLabel.text = "Credits: \(GameData.shared.totalCredits)"
                    let newShieldAmount = 100 + 50 * UserDefaults.standard.getUserShieldHealthUpgrades()
                    let purchaseAlert = UIAlertController(title: "Shield amount increased to \(newShieldAmount)!", message: "Remaining Credit Balance: \(GameData.shared.totalCredits)", preferredStyle: .alert)
                    purchaseAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.view?.window?.rootViewController?.present(purchaseAlert, animated: true, completion: nil)
                }
            }))
            self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
        }
        if shieldDurationUpgradeButton.contains(touchLocation) {
            let costToUpgrade = 1000 + GameData.shared.numberOfShieldDurationUpgrades * 1000
            let alert = UIAlertController(title: "Increase shield duration by 5 seconds?", message: "Credits: \(costToUpgrade)", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "No", style: .default, handler: { _ in
                NSLog("The \"NO\" alert occured.")
            }))
            alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { _ in
                NSLog("The \"Yes\" alert occured.")
                if GameData.shared.totalCredits < costToUpgrade {
                    let notEnoughCreditsAlert = UIAlertController(title: "Not Enough Credits", message: "Credits are earned by playing or can be purchased", preferredStyle: .alert)
                    notEnoughCreditsAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.view?.window?.rootViewController?.present(notEnoughCreditsAlert, animated: true, completion: nil)
                } else {
                    GameData.shared.totalCredits = GameData.shared.totalCredits - costToUpgrade
                    GameData.shared.numberOfShieldDurationUpgrades = GameData.shared.numberOfShieldDurationUpgrades + 1
                    UserDefaults.standard.setUserShieldDurationUpgrades(numberOfShieldDurationUpgrades: GameData.shared.numberOfShieldDurationUpgrades)
                    UserDefaults.standard.setUserCredits(credits: GameData.shared.totalCredits)
                    self.creditsLabel.text = "Credits: \(GameData.shared.totalCredits)"
                    let newShieldDuration = 10 + 5 * UserDefaults.standard.getUserShieldDurationUpgrades()
                    let purchaseAlert = UIAlertController(title: "Shield duration increased to \(newShieldDuration) seconds!", message: "Remaining Credit Balance: \(GameData.shared.totalCredits)", preferredStyle: .alert)
                    purchaseAlert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.view?.window?.rootViewController?.present(purchaseAlert, animated: true, completion: nil)
                }
            }))
            self.view?.window?.rootViewController?.present(alert, animated: true, completion: nil)
        }
    }
}

