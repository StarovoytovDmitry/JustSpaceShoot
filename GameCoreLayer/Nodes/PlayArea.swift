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
        let texture = SKTexture(imageNamed: "Shut_0")
        super.init(texture: texture, color: SKColor.clear, size: texture.size())
        alpha = CGFloat(0.0)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func Position(_ scene1: SKScene)->CGPoint {
        size = CGSize(width: scene1.size.width, height: scene1.size.height)
        position = CGPoint(x: scene1.size.width/2, y: scene1.size.height/2)
        physicsBody = SKPhysicsBody(rectangleOf: size)
        physicsBody?.isDynamic = true
        physicsBody?.affectedByGravity = false
        physicsBody?.categoryBitMask = PhysicsCatalog.area1
        physicsBody?.contactTestBitMask = PhysicsCatalog.plane1 | PhysicsCatalog.boomb1
        physicsBody?.collisionBitMask = 0
        return(position)
    }
}
