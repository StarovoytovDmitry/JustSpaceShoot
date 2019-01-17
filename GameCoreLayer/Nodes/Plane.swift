//
//  Plane.swift
//  game_dev1
//
//  Created by Дмитрий on 03.11.15.
//  Copyright © 2015 Дмитрий. All rights reserved.
//

import SpriteKit

class Plane: SKSpriteNode {
    
    //var emi : SKEmitterNode
    
    init() {
        let texture1 = SKTexture(imageNamed: "Suttle_3-4")
        super.init(texture: texture1, color: SKColor.clear, size: CGSize(width: 75, height: 65))
        name = "PlaneR"
        zPosition = 2
        physicsBody = SKPhysicsBody(rectangleOf: self.size)
        physicsBody?.categoryBitMask = PhysicsCatalog.plane1
        physicsBody?.contactTestBitMask = PhysicsCatalog.shut1 | PhysicsCatalog.line1 | PhysicsCatalog.area1 | PhysicsCatalog.killer1
        physicsBody?.collisionBitMask = 0
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = true
        physicsBody?.allowsRotation = false
        addSpark()//Slow?
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func addSpark() {
        let emi : SKEmitterNode
        emi = SKEmitterNode(fileNamed: "Spark1")!
        emi.zPosition = 3
        addChild(emi)
    }
    
    func Physics()->SKPhysicsBody {
        return(physicsBody)!
    }
    
    @discardableResult
    func Position(_ scene1: SKScene)->CGPoint {
        let MinValue = UInt32(0)
        let MaxValue = UInt32(scene1.size.width-100)
        let SpawnPoint = UInt32(MaxValue - MinValue)
        position = CGPoint(x: CGFloat(arc4random_uniform(SpawnPoint))+50, y: scene1.size.height)
        return(position)
    }
    //Action plane
    func Action(_ x: Int) {
        var action = SKAction()
        var duration : Double = Double()
        var dx : Double = 0.05*Double(x)
        if dx >= 3.0 {
            dx = 3.0
        }
        if x == 0 {
            duration = 5.0
        } else {
            duration = 5.0 - dx
        }
        
        action = SKAction.moveTo(y: -100, duration: duration)
        let actionDone = SKAction.removeFromParent()
        run(SKAction.sequence([action, actionDone]))
    }
}
