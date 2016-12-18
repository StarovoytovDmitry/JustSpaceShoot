//
//  Physics.swift
//  game_dev1
//
//  Created by Дмитрий on 11.07.16.
//  Copyright © 2016 Дмитрий. All rights reserved.
//

import SpriteKit
import UIKit

struct PhysicsCatalog {
    
    static let plane1 : UInt32 = 0x00
    static let shut1 : UInt32 = 0x01
    static let boomb1 : UInt32 = 0x02
    static let killer1 : UInt32 = 0x03
    static let line1 : UInt32 = 0x04
    static let area1 : UInt32 = 0x05
    static let limiter1 : UInt32 = 0x06
}

class PhysicsEffects: SKSpriteNode  {

    fileprivate func spaunEffect(_ position: CGPoint, scene: SKScene, time: Double){
        let effect = SKEmitterNode(fileNamed: effectShoot[number_shut])
        effect!.position = position
        scene.addChild(effect!)
        scene.run(SKAction.wait(forDuration: time), completion: { effect!.removeFromParent() })
    }
    
    fileprivate func spaunSoundEffect(_ scene: SKScene, soundname: String, time: Double) {
        scene.run(SKAction.playSoundFileNamed(soundname, waitForCompletion: false), completion: {SKAction.removeFromParent()})
    }
    
    //collision with emmiternode and sound in scene. ScoreF(T/F) - inc Score1 if True
    func collision(_ body1: SKSpriteNode?, body2: SKSpriteNode?, effectDuration: Double, scene: SKScene, ScoreF: Bool, Score1: Int)->Int {
        
        var positionEmitter: CGPoint = CGPoint()
        if body1 == nil {
            if body2 != nil {
                positionEmitter = (body2?.position)!
            }
        } else {
           positionEmitter = (body1?.position)!
        }
        
        spaunEffect(positionEmitter, scene: scene, time: effectDuration)
        
        if soundflag == true {
            let action = SKAction.playSoundFileNamed("killPlane.wav", waitForCompletion: false)
            let actionDone = SKAction.removeFromParent()
            scene.run(SKAction.sequence([action, actionDone]))
        }
        
        body1?.removeFromParent()
        body2?.removeFromParent()
        var LScore = Score1
        if ScoreF == true {
            LScore = LScore + 1
        }
        return(LScore)
    }
    //collision. Score1 = Score1 + 1
    func collision(_ body1: SKSpriteNode?, body2: SKSpriteNode?, Score1: Int)->Int {
        body1?.removeFromParent()
        body2?.removeFromParent()
        var LScore = Score1
        LScore += 1
        return(LScore)
    }
    func collision(_ body1: SKSpriteNode?, body2: SKSpriteNode?){
        body1?.removeFromParent()
        body2?.removeFromParent()
    }
    func collision(_ body: SKSpriteNode?){
        body?.removeFromParent()
    }
    //Make joint
    func Joint(_ bodyA:SKSpriteNode, bodyB:SKSpriteNode, scene1:SKScene) {
        
        let AB = SKPhysicsJointPin.joint(withBodyA: bodyA.physicsBody! ,bodyB: bodyB.physicsBody!, anchor: bodyB.position)
        scene1.physicsWorld.add(AB)
        
    }
    //Free all joints
    func freeJoints(_ scene1:SKScene) {
        scene1.physicsWorld.removeAllJoints()
    }
}
