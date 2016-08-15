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
        navigationController?.interactivePopGestureRecognizer?.enabled = false
        
        
        super.viewDidLoad()
        // Configure the view.
        skView = self.view as! SKView
        /* Sprite Kit applies additional optimizations to improve rendering performance */
        skView.ignoresSiblingOrder = true
        if gameinaction == false {
            scene1 = GameScene(fileNamed: "GameScene")!
        }
            /* Set the scale mode to scale to fit the window */
        scene1!.scaleMode = .Fill
            
        skView.presentScene(scene1)
        
    }
    
    override func viewDidAppear(animated: Bool) {
        navigationController?.interactivePopGestureRecognizer?.enabled = false
    }
    
    override func viewWillAppear(animated: Bool) {
        navigationController?.interactivePopGestureRecognizer?.enabled = false
    }
    
    deinit{
        scene1!.endScene()
        scene1 = nil
        //print("deinit GameViewController")
    }
    
    override func shouldAutorotate() -> Bool {
        return true
    }

    override func supportedInterfaceOrientations() -> UIInterfaceOrientationMask {
        if UIDevice.currentDevice().userInterfaceIdiom == .Phone {
            return .AllButUpsideDown
        } else {
            return .All
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}
