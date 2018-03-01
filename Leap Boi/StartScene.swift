//
//  StartScene.swift
//  Leap Boi
//
//  Created by Robert Desjardins on 2018-02-27.
//  Copyright © 2018 Robert Desjardins. All rights reserved.
//

import SpriteKit
import GameplayKit
import CoreMotion

class StartScene: SKScene {
    let background = SKSpriteNode(imageNamed: "starbackground")
    
    
    override func didMove(to view: SKView) {
        GameData.shared.playerHighScore = UserDefaults.standard.getUserHighScores()
        createBackground()
        createStartButton()
        createHighScoreButton()
        //print(GameData.shared.playerHighScore)
    }
    
    func createBackground() {
        let background = SKSpriteNode(imageNamed: "starbackground")
        background.zPosition = 1
        background.size = CGSize(width: background.size.width, height: frame.size.height)
        background.position = CGPoint(x: frame.size.width / 2, y: frame.size.height / 2)
        addChild(background)
    }
    
    func createStartButton() {
        let restartButton = UIButton(frame: CGRect(x: self.size.width/2 - 100, y: 1.0 / 3.0 * self.size.height, width: 200, height: 100))
        restartButton.titleLabel?.font = UIFont(name: "Avenir", size: 45)
        restartButton.titleLabel?.textAlignment = NSTextAlignment.center
        restartButton.backgroundColor = #colorLiteral(red: 0.7971752948, green: 0.8071641785, blue: 1, alpha: 0.466020976)
        restartButton.setTitleColor(.white, for: .normal)
        restartButton.layer.borderWidth = 5
        restartButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        restartButton.layer.cornerRadius = 10
        restartButton.clipsToBounds = true
        restartButton.setTitle("Start", for: .normal)
        restartButton.addTarget(self, action: #selector(startButtonAction), for: .touchUpInside)
        
        self.view?.addSubview(restartButton)
    }
    
    @objc func startButtonAction(sender: UIButton!) {
        for locView in (self.view?.subviews)! {
            locView.removeFromSuperview()
        }
        gameSceneLoad(view: view!)
    }
    
    func createHighScoreButton() {
        let highScoreButton = UIButton(frame: CGRect(x: self.size.width/2 - 90, y: 2.0 / 3.0 * self.size.height, width: 180, height: 90))
        highScoreButton.titleLabel?.font = UIFont(name: "Avenir", size: 25)
        highScoreButton.titleLabel?.textAlignment = NSTextAlignment.center
        highScoreButton.backgroundColor = #colorLiteral(red: 0.7971752948, green: 0.8071641785, blue: 1, alpha: 0.466020976)
        highScoreButton.setTitleColor(.white, for: .normal)
        highScoreButton.layer.borderWidth = 5
        highScoreButton.layer.borderColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        highScoreButton.layer.cornerRadius = 10
        highScoreButton.clipsToBounds = true
        highScoreButton.setTitle("High Scores", for: .normal)
        highScoreButton.addTarget(self, action: #selector(highScoreButtonAction), for: .touchUpInside)
        
        self.view?.addSubview(highScoreButton)
    }
    
    @objc func highScoreButtonAction(sender: UIButton!) {
        for locView in (self.view?.subviews)! {
            locView.removeFromSuperview()
        }
        highScoreSceneLoad(view: view!)
    }
    
}

