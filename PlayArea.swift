//
//  PlayArea.swift
//  game_dev1
//
//  Created by Дмитрий on 20.07.16.
//  Copyright © 2016 Дмитрий. All rights reserved.
//

import SpriteKit

class PlayArea: SKSpriteNode {
    
    init(){
        let texture = SKTexture(imageNamed: "Shut_1")
        super.init(texture: texture, color: SKColor.clearColor(), size: texture.size())
        alpha = CGFloat(0.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func Position(scene1: SKScene)->CGPoint {
        size = CGSizeMake(scene1.size.width, scene1.size.height)
        position = CGPoint(x: scene1.size.width/2, y: scene1.size.height/2)
        physicsBody = SKPhysicsBody(rectangleOfSize: size)
        physicsBody?.dynamic = true
        physicsBody?.affectedByGravity = false
        physicsBody?.categoryBitMask = PhysicsCatalog.area1
        physicsBody?.contactTestBitMask = PhysicsCatalog.plane1 | PhysicsCatalog.boomb1
        physicsBody?.collisionBitMask = 0
        return(position)
    }
}
