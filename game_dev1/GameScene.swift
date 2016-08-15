//
//  GameScene.swift
//  game_dev1
//
//  Created by Дмитрий on 14.10.15.
//  Copyright (c) 2015 Дмитрий. All rights reserved.
//
import SpriteKit
import UIKit

class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //weak var gameViewController: GameViewController? = GameViewController()
    let player: Player = Player(image1: playerArray[number_player_image]!, player_lives: lives)
    private let play_area: PlayArea = PlayArea()
    private let pause: SKSpriteNode = SKSpriteNode(imageNamed: "Pause_button-4")
    //private let heart: SKSpriteNode = SKSpriteNode(imageNamed: "Heart-4")
    private let soundOn : SKSpriteNode = SKSpriteNode(imageNamed: "SoundOn")
    private let soundOff : SKSpriteNode = SKSpriteNode(imageNamed: "SoundOff")
    
    private let resume: SKLabelNode = SKLabelNode(fontNamed: "standard 07_53")
    private let restart: SKLabelNode = SKLabelNode(fontNamed: "standard 07_53")
    
    private var score_Label = UILabel()
    private var live_Label = UILabel()
    private var resume_Label = UILabel()
    private var restart_Label = UILabel()
    private var menu_Label = UILabel()
    
    var gun = NSTimer()
    var spaun = NSTimer()
    var free = NSTimer()
    
    override func didMoveToView(view: SKView) {
        //print("init GameScene")
        physicsWorld.contactDelegate = self
        
        gameinaction = true
        
        SceneSetting()

        Timers()
        
        player.Position(self)
        addChild(player)
        
        play_area.Position(self)
        addChild(play_area)
        
        PauseButton()
        //
        SoundButtonOn()
        //
        score = 0
    }
    
    func Timers() {
        gun = NSTimer.scheduledTimerWithTimeInterval(0.6, target: self, selector: #selector(Shuter), userInfo: nil, repeats: true)
        spaun = NSTimer.scheduledTimerWithTimeInterval(1.2, target: self, selector: #selector(Go), userInfo: nil, repeats: true)
        free = NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: #selector(freeJoins), userInfo: nil, repeats: true)
    }
    //shut of player
    func Shuter(){
        if gameinaction == true {
        let shut: Shot = Shot(image1: imageShoot[number_shut]!)
        shut.Position(player.position)
        shut.Action(self, duration: 1.6)
        self.addChild(shut)
        }
    }
    //plane with bomb
    func Go(){
        if gameinaction == true {
            let planeR: Plane = Plane()
            planeR.Position(self)
            if randomBool() == true {
                let boombR: Boomb = Boomb()
                boombR.Position(planeR.Position(self))
                self.addChild(boombR)
                self.addChild(planeR)
                physics1.Joint(planeR, bodyB: boombR, scene1: self)
                //boombR.Action()
            } else {
                self.addChild(planeR)
            }
            planeR.Action(score)
        }
    }
    //free all joints
    func freeJoins() {
        if gameinaction == true {
            physics1.freeJoints(self)
        }
    }
    
    private func randomBool() -> Bool {
        return arc4random_uniform(2) == 0 ? true: false
    }
    
    //Несовершенный метод!
    func update_live_score(){
        live_Label.text = ("Lives: \(player.playerlives)")
        score_Label.text = ("Score: \(score)")
    }
    
        //Stop timers
    private func stopTimers(timers: NSTimer...){
        for i in timers {
            i.invalidate()
        }
    }
    //Fire timers
    private func fireTimers(timers: NSTimer...){
        for i in timers {
            i.fire()
        }
    }
    
    func endScene(){
        saveRecord(score)
        gameinaction = false
        stopTimers(gun, spaun, free)
        removeAllChildren()
        removeAllActions()
    }
    //Stop Scene
    func stopScene(){
        saveRecord(score)
        gameinaction = false
        stopTimers(gun, spaun, free)
        
        removeAllChildren()
        removeAllActions()
        let gameover: SKLabelNode = SKLabelNode(fontNamed: "standard 07_53")
        gameover.text = "GAME OVER"
        gameover.position = CGPoint(x: self.size.width/2, y: self.size.height/2+400)
        gameover.zPosition = 3
        gameover.fontSize = 100
        gameover.fontColor = UIColor(red:0.70, green:0.13, blue:0.13, alpha:1.0)
        gameover.name = "GameOver"
        self.addChild(gameover)
        
        player.playerlives = 0
    }
    //Pause Scene
    func pauseScene() {
        gameinaction = false
        //paused = true
        pause.removeFromParent()
        ResumeButtons(true, addRestart: true)
        alpha = 0.8
        speed = 0.0
        physicsWorld.speed = 0.0
    }
    //Run Scene
    func runScene() {
        gameinaction = true
        addChild(pause)
        //paused = false
        alpha = 1.0
        speed = 1.0
        physicsWorld.speed = 1.0
        resume.removeFromParent()
        restart.removeFromParent()
    }
    //Restart Scene
    func restartScene() {
        stopTimers(gun, spaun, free)
        removeAllActions()
        removeAllChildren()
        player.playerlives = lives
        score = 0
        Timers()
        
        addChild(player)
        addChild(play_area)
        if soundflag == false {
            SoundButtonOff()
        } else {
            SoundButtonOn()
        }
        speed = 1.0
        physicsWorld.speed = 1.0
        runScene()
        update_live_score()
        
        let emi2 = SKEmitterNode(fileNamed: "MyParticle")
        emi2?.position = CGPoint(x: self.size.width/2, y: self.size.height)
        addChild(emi2!)
    }
    //Save new record
    func saveRecord(score: Int) {
        if score > score_record {
            score_record = score
            let defaults = NSUserDefaults.standardUserDefaults()
            defaults.setInteger(score_record, forKey: "ScoreRecord")
            defaults.synchronize()
        }
    }
    
    override func touchesMoved(touches: Set<UITouch>, withEvent event: UIEvent?) {
        
        for touch: AnyObject in touches {
            let location = touch.locationInNode(self)
            if gameinaction == true {
            player.position.x = location.x
            }
        }
    }
    
    func SceneSetting() {
        
        self.backgroundColor = imageArray[number_background]
        ScoreLabel()
        LiveLabel()
        update_live_score()
        
        let emi2 = SKEmitterNode(fileNamed: "MyParticle")
        emi2?.position = CGPoint(x: self.size.width/2, y: self.size.height)
        addChild(emi2!)
        
    }
    
    //touch
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
    
        for touch: AnyObject in touches {
            //Вызов паузы
            let location = touch.locationInNode(self)
            let node = self.nodeAtPoint(location)
            if (node.name == "PauseButton") {
                pauseScene()
            }
            if (node.name == "ResumeButton") {
                runScene()
            }
            if (node.name == "RestartButton") {
                restartScene()
            }
            if (node.name == "SoundButtonOn") {
                SoundButtonOff()
            }
            if (node.name == "SoundButtonOff") {
                SoundButtonOn()
            }
        }
    }
    func ScoreLabel() {
        score_Label = UILabel(frame: CGRectMake(100, 2*UIApplication.sharedApplication().statusBarFrame.size.height, 200, 20))
        score_Label.textAlignment = NSTextAlignment.Left
        score_Label.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.0)
        score_Label.textColor = UIColor.whiteColor()
        score_Label.font = UIFont.init(name: "standard 07_53", size: 14)
        self.view?.addSubview(score_Label)
    }
    func LiveLabel() {
        live_Label = UILabel(frame: CGRectMake(100, UIApplication.sharedApplication().statusBarFrame.size.height, 100, 20))
        live_Label.textAlignment = NSTextAlignment.Left
        live_Label.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.0)
        live_Label.textColor = UIColor.whiteColor()
        live_Label.font = UIFont.init(name: "standard 07_53", size: 14)
        self.view?.addSubview(live_Label)
    }
    func PauseButton() {
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.size.height
        pause.position = CGPointMake(self.size.width-70, self.size.height - 15*statusBarHeight)
        pause.zPosition = 3
        pause.size = CGSizeMake(100, 100)
        pause.name = "PauseButton"
        self.addChild(pause)
    }
    func SoundButtonOn() {
        soundOff.removeFromParent()
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.size.height
        soundOn.position = CGPointMake(self.size.width-70, self.size.height - 23*statusBarHeight)
        soundOn.zPosition = 3
        soundOn.size = CGSizeMake(100, 100)
        soundOn.name = "SoundButtonOn"
        self.addChild(soundOn)
        soundflag = true
    }
    
    func SoundButtonOff() {
        soundOn.removeFromParent()
        let statusBarHeight = UIApplication.sharedApplication().statusBarFrame.size.height
        soundOff.position = CGPointMake(self.size.width-70, self.size.height - 23*statusBarHeight)
        soundOff.zPosition = 3
        soundOff.size = CGSizeMake(100, 100)
        soundOff.name = "SoundButtonOff"
        self.addChild(soundOff)
        soundflag = false
    }
    
    func ResumeButtons(addResume: Bool, addRestart: Bool) {
        if addResume == true {
        resume.text = "Resume"
        resume.position = CGPoint(x: self.size.width/2, y: self.size.height/2 + 100)
        resume.zPosition = 3
        resume.fontSize = 50
        resume.name = "ResumeButton"
        self.addChild(resume)
        }
        if addRestart == true {
        restart.text = "Restart"
        restart.position = CGPoint(x: self.size.width/2, y: self.size.height/2)
        restart.zPosition = 3
        restart.fontSize = 50
        restart.fontColor = UIColor(red:0.70, green:0.13, blue:0.13, alpha:1.0)
        restart.name = "RestartButton"
        self.addChild(restart)
        }
    }
    
    deinit{
        saveRecord(score)
        gameinaction = false
        stopTimers(gun, spaun, free)
        removeAllActions()
        removeAllChildren()
        //print("deinit GameScene")
    }
}
