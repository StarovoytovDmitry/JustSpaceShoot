//
//  Shot.swift
//  game_dev1
//
//  Created by Дмитрий on 25.11.15.
//  Copyright © 2015 Дмитрий. All rights reserved.
//

import SpriteKit

class Shot: SKSpriteNode {
    
    init(image1: UIImage){
        let texture1 = SKTexture(image: image1)
        super.init(texture: texture1, color: SKColor.clear, size: texture1.size())
        name = "Shut"
        size = CGSize(width: 20, height: 40)
        zPosition = 1
        texture = texture1
        physicsBody = SKPhysicsBody(rectangleOf: self.size)
        physicsBody?.categoryBitMask = PhysicsCatalog.shut1
        physicsBody?.contactTestBitMask = PhysicsCatalog.plane1 | PhysicsCatalog.boomb1
        physicsBody?.collisionBitMask = 0
        physicsBody?.affectedByGravity = false
        physicsBody?.isDynamic = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func physics()->SKPhysicsBody{
        return(physicsBody)!
    }
    
    func Position(_ x1: CGPoint)->CGPoint{
        position = CGPoint(x: x1.x, y: x1.y+100)
        return(position)
    }
    
    func Action(_ scene1: SKScene, duration: Double){
        let action = SKAction.moveTo(y: scene1.size.height, duration: duration)
        let actionDone = SKAction.removeFromParent()
        if soundflag == true {
            scene1.run(SKAction.playSoundFileNamed(soundShoot[number_shut], waitForCompletion: false))//Трабла с памятью??? Сделать как в спаун эффект!!!
        }
        run(SKAction.sequence([action, actionDone]))
    }
}
