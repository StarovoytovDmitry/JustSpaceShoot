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
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func Position(is_left: Bool, _ scene1: SKScene)->CGPoint {
        size = CGSize(width: 20, height: 400)
        if is_left == true {
            position = CGPoint(x: -20, y: 0)
        } else {
            position = CGPoint(x: self.size.width+20, y: 0)
        }
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.isDynamic = true
        physicsBody?.affectedByGravity = false
        physicsBody?.categoryBitMask = PhysicsCatalog.limiter1
        physicsBody?.contactTestBitMask = PhysicsCatalog.shut1
        physicsBody?.collisionBitMask = 0
    }
}
