//
//  Boomb.swift
//  game_dev1
//
//  Created by Дмитрий on 19.11.15.
//  Copyright © 2015 Дмитрий. All rights reserved.
//

import SpriteKit

class Boomb: SKSpriteNode {
    
    init(){
        let texture = SKTexture(imageNamed: "Star-4")
        super.init(texture: texture, color: SKColor.clear, size: texture.size())
        name = "BoombB"
        zPosition = 1
        physicsBody = SKPhysicsBody(circleOfRadius: self.size.height/2)
        physicsBody?.categoryBitMask = PhysicsCatalog.boomb1
        physicsBody?.contactTestBitMask = PhysicsCatalog.killer1 | PhysicsCatalog.shut1 | PhysicsCatalog.area1
        physicsBody?.collisionBitMask = 0
        physicsBody?.affectedByGravity = true
        physicsBody?.isDynamic = true
        physicsBody?.allowsRotation = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func Physics()->SKPhysicsBody{
        return(physicsBody)!
    }
    
    func remove(_ scene:SKScene){
        
    }
    
    @discardableResult
    func Position(_ x: CGPoint)->CGPoint{
        position = x
        return(position)
    }
    
    func Action(){
        let action = SKAction.moveTo(y: -100, duration: 3.0)
        let actionDone = SKAction.removeFromParent()
        self.run(SKAction.sequence([action, actionDone]))
    }
}
