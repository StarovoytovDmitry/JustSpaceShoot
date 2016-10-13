//
//  GameViewController.swift
//  game_dev1
//
//  Created by Дмитрий on 14.10.15.
//  Copyright (c) 2015 Дмитрий. All rights reserved.
//

import UIKit
import SpriteKit

class GameViewController: UIViewController{
    var skView: SKView = SKView()
    override func viewDidLoad() {
        //print("init GameViewController")
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        
        super.viewDidLoad()
        // Configure the view.
        skView = self.view as! SKView
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        if gameinaction == false {
            scene1 = GameScene(fileNamed: "GameScene")!
        }
            /* Set the scale mode to scale to fit the window */
        scene1!.scaleMode = .fill
        skView.showsPhysics = true
            
        skView.presentScene(scene1)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.interactivePopGestureRecognizer?.isEnabled = false
    }
    
    deinit{
        scene1!.endScene()
        scene1 = nil
        //print("deinit GameViewController")
    }
    
    override var shouldAutorotate : Bool {
        return true
    }

    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
