//
//  GameScenePhysics.swift
//  Space Shoot
//
//  Created by Дмитрий on 05.08.16.
//  Copyright © 2016 Дмитрий. All rights reserved.
//

import SpriteKit

extension GameScene {
    //BeginContacts
    func didBeginContact(contact: SKPhysicsContact) {
        
        let firstBody : SKPhysicsBody// = contact.bodyA
        let secondBody : SKPhysicsBody// = contact.bodyB
        
        if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
        {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        /*
        firstBody.usesPreciseCollisionDetection = true
        secondBody.usesPreciseCollisionDetection = true
        */
        //collision shut with plane and boomb
        if ((firstBody.categoryBitMask == PhysicsCatalog.plane1) && (secondBody.categoryBitMask == PhysicsCatalog.shut1) ||
            (firstBody.categoryBitMask == PhysicsCatalog.shut1) && (secondBody.categoryBitMask == PhysicsCatalog.plane1)||(firstBody.categoryBitMask == PhysicsCatalog.boomb1) && (secondBody.categoryBitMask == PhysicsCatalog.shut1) ||
            (firstBody.categoryBitMask == PhysicsCatalog.shut1) && (secondBody.categoryBitMask == PhysicsCatalog.boomb1)){
            score=physics1.collision(firstBody.node as? SKSpriteNode , body2: secondBody.node as? SKSpriteNode, effectDuration: 0.3, scene: self, ScoreF: true, Score1: score)
        }
        //collision boomb with player
        if (firstBody.categoryBitMask == PhysicsCatalog.killer1) && (secondBody.categoryBitMask == PhysicsCatalog.boomb1){
            player.playerlives -= 1
            physics1.collision(secondBody.node as? SKSpriteNode)
            if player.playerlives <= 0 {
                stopScene()
                ResumeButtons(false, addRestart: true)
            }
        }
        if (firstBody.categoryBitMask == PhysicsCatalog.boomb1) && (secondBody.categoryBitMask == PhysicsCatalog.killer1){
            player.playerlives -= 1
            physics1.collision(firstBody.node as? SKSpriteNode)
            if player.playerlives <= 0 {
                stopScene()
                ResumeButtons(false, addRestart: true)
            }
        }
        update_live_score()
        if score > score_record {
            score_record = score
        }
    }
    //EndContacts
    func didEndContact(contact: SKPhysicsContact) {
        let firstBody : SKPhysicsBody// = contact.bodyA
        let secondBody : SKPhysicsBody// = contact.bodyB
        
        if (contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask)
        {
            firstBody = contact.bodyA
            secondBody = contact.bodyB
        }
        else {
            firstBody = contact.bodyB
            secondBody = contact.bodyA
        }
        //EndPlayArea
        if (firstBody.categoryBitMask == PhysicsCatalog.boomb1) && (secondBody.categoryBitMask == PhysicsCatalog.area1){
            physics1.collision(firstBody.node as? SKSpriteNode)
        }
        if (firstBody.categoryBitMask == PhysicsCatalog.area1) && (secondBody.categoryBitMask == PhysicsCatalog.boomb1){
            physics1.collision(secondBody.node as? SKSpriteNode)
        }
        if ((firstBody.categoryBitMask == PhysicsCatalog.plane1) && (secondBody.categoryBitMask == PhysicsCatalog.area1) ||
            (firstBody.categoryBitMask == PhysicsCatalog.area1) && (secondBody.categoryBitMask == PhysicsCatalog.plane1)){
            player.playerlives -= 1
            if player.playerlives <= 0 {
                stopScene()
                ResumeButtons(false, addRestart: true)
            }
        }
        update_live_score()
    }

}
