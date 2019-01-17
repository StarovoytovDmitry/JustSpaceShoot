//
//  GameScene.swift
//  game_dev1
//
//  Created by Дмитрий on 14.10.15.
//  Copyright (c) 2015 Дмитрий. All rights reserved.
//
import SpriteKit
import UIKit
import CoreMotion

/*
struct CMAcceleration {
    var x: Double
    var y: Double
    var z: Double
    //init()
    init(x: Double, y: Double, z: Double){
        self.x = x
        self.y = y
        self.z = z
    }
}
*/
class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //weak var gameViewController: GameViewController? = GameViewController()
    let player: Player = Player(image1: ResoursesConstants.playerArray[GlobalConstants.number_player_image]!, player_lives: GlobalConstants.lives)
    fileprivate let play_area: PlayArea = PlayArea()
    fileprivate let limiter_area1: Limiter = Limiter()
    fileprivate let limiter_area2: Limiter = Limiter()
    fileprivate let pause: SKSpriteNode = SKSpriteNode(imageNamed: "Pause_button-4")
    //private let heart: SKSpriteNode = SKSpriteNode(imageNamed: "Heart-4")
    fileprivate let soundOn : SKSpriteNode = SKSpriteNode(imageNamed: "SoundOn")
    fileprivate let soundOff : SKSpriteNode = SKSpriteNode(imageNamed: "SoundOff")
    
    fileprivate let resume: SKLabelNode = SKLabelNode(fontNamed: "standard 07_53")
    fileprivate let restart: SKLabelNode = SKLabelNode(fontNamed: "standard 07_53")
    
    fileprivate var score_Label = UILabel()
    fileprivate var live_Label = UILabel()
    fileprivate var resume_Label = UILabel()
    fileprivate var restart_Label = UILabel()
    fileprivate var menu_Label = UILabel()
    
    var gun = Timer()
    var spaun = Timer()
    var free = Timer()
    
    var motionManager = CMMotionManager()
    var destX : CGFloat  = 0.0
    
    override func didMove(to view: SKView) {
        
        physicsWorld.contactDelegate = self
        
        GlobalConstants.gameinaction = true
        
        SceneSetting()

        Timers()
        
        player.Position(self)
        addChild(player)
        
        play_area.Position(self)
        addChild(play_area)
        
        Limiters()
        //
        PauseButton()
        //
        SoundButtonOff()
        //
        GlobalConstants.score = 0
        //Tolerance of Timers
        gun.tolerance = 0.06
        spaun.tolerance = 1.0
        free.tolerance = 1.0
        
        motionManager.startAccelerometerUpdates()
    }
    // Accelerometer
    func processUserMotion(forUpdate currentTime: CFTimeInterval) {
        //if let ship = player as? SKSpriteNode {
            if let data = motionManager.accelerometerData {
                if fabs(data.acceleration.x) > 0.1 {
                    // 4 How do you move the ship?
                    print("Acceleration: \(data.acceleration.x)")
                    player.physicsBody!.applyForce(CGVector(dx: 100 * CGFloat(data.acceleration.x), dy: 0))
                }
            }
        //}
    }
    
    override func update(_ currentTime: TimeInterval) {
        processUserMotion(forUpdate: currentTime)
    }
    
    
    func Timers() {
        gun = Timer.scheduledTimer(timeInterval: 0.6, target: self, selector: #selector(Shuter), userInfo: nil, repeats: true)
        spaun = Timer.scheduledTimer(timeInterval: 1.2, target: self, selector: #selector(Go), userInfo: nil, repeats: true)
        free = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(freeJoins), userInfo: nil, repeats: true)
    }
    //Limiters of area
    func Limiters(){
        limiter_area1.Position(is_left: true, self)
        addChild(limiter_area1)
        
        limiter_area2.Position(is_left: false, self)
        addChild(limiter_area2)
    }

    // Shut of player
    @objc func Shuter(){
        if GlobalConstants.gameinaction == true {
            let shut: Shot = Shot(image1: ResoursesConstants.imageShoot[GlobalConstants.number_shut]!)
            shut.Position(player.position)
            shut.Action(self, duration: 1.6)
            self.addChild(shut)
        }
    }
    // Plane with bomb
    @objc func Go(){
        if GlobalConstants.gameinaction == true {
            let planeR: Plane = Plane()
            planeR.Position(self)
            if randomBool() == true {
                let boombR: Boomb = Boomb()
                boombR.Position(planeR.Position(self))
                self.addChild(boombR)
                self.addChild(planeR)
                PhysicsEffects.shared.Joint(planeR, bodyB: boombR, scene1: self)
                //boombR.Action()
            } else {
                self.addChild(planeR)
            }
            planeR.Action(GlobalConstants.score)
        }
    }
    // Free all joints
    @objc func freeJoins() {
        if GlobalConstants.gameinaction == true {
            PhysicsEffects.shared.freeJoints(self)
        }
    }
    
    fileprivate func randomBool() -> Bool {
        return arc4random_uniform(2) == 0 ? true: false
    }
    
    //Несовершенный метод!
    func update_live_score(){
        live_Label.text = ("Lives: \(player.playerlives)")
        score_Label.text = ("Score: \(GlobalConstants.score)")
    }
    
    //Stop timers
    fileprivate func stopTimers(_ timers: Timer...){
        for i in timers {
            i.invalidate()
        }
    }
    //Fire timers
    fileprivate func fireTimers(_ timers: Timer...){
        for i in timers {
            i.fire()
        }
    }
    
    func endScene(){
        saveRecord(GlobalConstants.score)
        GlobalConstants.gameinaction = false
        stopTimers(gun, spaun, free)
        removeAllChildren()
        removeAllActions()
    }
    //Stop Scene
    func stopScene(){
        saveRecord(GlobalConstants.score)
        GlobalConstants.gameinaction = false
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
        GlobalConstants.gameinaction = false
        //paused = true
        pause.removeFromParent()
        ResumeButtons(true, addRestart: true)
        alpha = 0.8
        speed = 0.0
        physicsWorld.speed = 0.0
    }
    //Run Scene
    func runScene() {
        GlobalConstants.gameinaction = true
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
        player.playerlives = GlobalConstants.lives
        GlobalConstants.score = 0
        Timers()
        
        addChild(player)
        player.Position(self)
        addChild(play_area)
        Limiters()
        if GlobalConstants.soundflag == false {
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
    func saveRecord(_ score: Int) {
        if score >= GlobalConstants.score_record {
            GlobalConstants.score_record = score
            let defaults = UserDefaults.standard
            defaults.set(GlobalConstants.score_record, forKey: "Record")
            defaults.synchronize()
        }
    }
    /*
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        for touch: AnyObject in touches {
            let location = touch.location(in: self)
            if gameinaction == true {
                player.position.x = location.x
            }
        }
        
    }
    */
    func SceneSetting() {
        
        self.backgroundColor = ResoursesConstants.imageArray[GlobalConstants.number_background]
        ScoreLabel()
        LiveLabel()
        update_live_score()
        
        let emi2 = SKEmitterNode(fileNamed: "MyParticle")
        emi2?.position = CGPoint(x: self.size.width/2, y: self.size.height)
        addChild(emi2!)
        
    }
    
    //touch
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        for touch: AnyObject in touches {
            //Вызов паузы
            let location = touch.location(in: self)
            let node = self.atPoint(location)
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
        score_Label = UILabel(frame: CGRect(x: 100, y: 2*UIApplication.shared.statusBarFrame.size.height, width: 200, height: 20))
        score_Label.textAlignment = NSTextAlignment.left
        score_Label.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.0)
        score_Label.textColor = UIColor.white
        score_Label.font = UIFont.init(name: "standard 07_53", size: 14)
        self.view?.addSubview(score_Label)
    }
    func LiveLabel() {
        live_Label = UILabel(frame: CGRect(x: 100, y: UIApplication.shared.statusBarFrame.size.height, width: 100, height: 20))
        live_Label.textAlignment = NSTextAlignment.left
        live_Label.backgroundColor = UIColor(red: 0.1, green: 0.1, blue: 0.1, alpha: 0.0)
        live_Label.textColor = UIColor.white
        live_Label.font = UIFont.init(name: "standard 07_53", size: 14)
        self.view?.addSubview(live_Label)
    }
    func PauseButton() {
        let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        pause.position = CGPoint(x: self.size.width-70, y: self.size.height - 15*statusBarHeight)
        pause.zPosition = 3
        pause.size = CGSize(width: 100, height: 100)
        pause.name = "PauseButton"
        self.addChild(pause)
    }
    func SoundButtonOn() {
        soundOff.removeFromParent()
        let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        soundOn.position = CGPoint(x: self.size.width-70, y: self.size.height - 23*statusBarHeight)
        soundOn.zPosition = 3
        soundOn.size = CGSize(width: 100, height: 100)
        soundOn.name = "SoundButtonOn"
        self.addChild(soundOn)
        GlobalConstants.soundflag = true
    }
    
    func SoundButtonOff() {
        soundOn.removeFromParent()
        let statusBarHeight = UIApplication.shared.statusBarFrame.size.height
        soundOff.position = CGPoint(x: self.size.width-70, y: self.size.height - 23*statusBarHeight)
        soundOff.zPosition = 3
        soundOff.size = CGSize(width: 100, height: 100)
        soundOff.name = "SoundButtonOff"
        self.addChild(soundOff)
        GlobalConstants.soundflag = false
    }
    
    func ResumeButtons(_ addResume: Bool, addRestart: Bool) {
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
        saveRecord(GlobalConstants.score)
        GlobalConstants.gameinaction = false
        stopTimers(gun, spaun, free)
        removeAllActions()
        removeAllChildren()
    }
}
