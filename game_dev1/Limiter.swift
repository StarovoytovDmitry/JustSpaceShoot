//
//  Limiter.swift
//  Just Space Shoot
//
//  Created by Дмитрий on 18.12.16.
//  Copyright © 2016 Дмитрий. All rights reserved.
//

import SpriteKit

class Limiter: SKSpriteNode {
    
    init(){
        let texture = SKTexture(imageNamed: "Shut_0")
        super.init(texture: texture, color: SKColor.clear, size: texture.size())
        alpha = CGFloat(1.0)
        zPosition = 2
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func Position(is_left: Bool, _ scene1: SKScene) {
        size = CGSize(width: 20, height: 400)
        if is_left == true {
            position = CGPoint(x: -10, y: 0)
        } else {
            position = CGPoint(x: scene1.size.width+10, y: 0)
        }
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.isDynamic = false
        physicsBody?.affectedByGravity = false
        physicsBody?.categoryBitMask = PhysicsCatalog.limiter1
        physicsBody?.contactTestBitMask = PhysicsCatalog.limiter1 | PhysicsCatalog.killer1
        physicsBody?.collisionBitMask = PhysicsCatalog.limiter1 | PhysicsCatalog.killer1
    }
}
