//
//  Player.swift
//  game_dev1
//
//  Created by Дмитрий on 25.11.15.
//  Copyright © 2015 Дмитрий. All rights reserved.
//

import SpriteKit

class Player: SKSpriteNode {
    
    var playerlives : Int = 3 // defaults value lives = 3
    
    init(image1: UIImage, player_lives: Int) {
        let texture1 = SKTexture(image: image1)
        super.init(texture: texture1, color: SKColor.clearColor(), size: CGSizeMake(112, 164))
        name = "FireMaker"
        texture = texture1
        zPosition = 2
        physicsBody = SKPhysicsBody(rectangleOfSize: self.size)
        physicsBody?.categoryBitMask = PhysicsCatalog.killer1
        physicsBody?.contactTestBitMask = PhysicsCatalog.boomb1
        physicsBody?.collisionBitMask = 0
        physicsBody?.affectedByGravity = false
        physicsBody?.dynamic = false
        physicsBody?.allowsRotation = false
        playerlives = player_lives
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func Physics()->SKPhysicsBody {
        return(physicsBody)!
    }
    
    func Position(scene1: SKScene)->CGPoint {
        position = CGPointMake(scene1.size.width/2, scene1.size.height/40+30)
        return(position)
    }
}
