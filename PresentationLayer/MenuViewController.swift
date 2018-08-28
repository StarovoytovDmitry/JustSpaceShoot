//
//  MenuViewController.swift
//  game_dev1
//
//  Created by Дмитрий on 15.07.16.
//  Copyright © 2016 Дмитрий. All rights reserved.
//

import UIKit

class MenuViewController: UIViewController {
    
    @IBOutlet weak var recordLabel: UILabel!
    
    override func viewDidLoad() {
        
        navigationItem.title = "Menu"
        let label = UILabel()
        label.font = UIFont(name: "standard 07_53", size: 19)
        navigationItem.titleView = label
        
        //set settings values
        let defaults = UserDefaults.standard
        number_background = defaults.integer(forKey: "BackGameScene")
        number_player_image = defaults.integer(forKey: "NumberPlayerImage")
        number_shut = defaults.integer(forKey: "NumberShutImage")
        score_record = defaults.integer(forKey: "Record")
        recordLabel.text = "Your best : \(score_record)"
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        self.view.backgroundColor = imageArray[number_background]
        recordLabel.text = "Your best : \(score_record)"
        
    }
    
    override func didReceiveMemoryWarning() {
        
        super.didReceiveMemoryWarning()
        
    }
}
