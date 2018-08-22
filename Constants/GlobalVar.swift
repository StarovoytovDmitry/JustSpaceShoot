//
//  globalvar.swift
//  game_dev1
//
//  Created by Дмитрий on 19.07.16.
//  Copyright © 2016 Дмитрий. All rights reserved.
//

import UIKit
import SpriteKit

var lives : Int = 3
var score : Int = 0
var number_background : Int = 0 //Сolor number of the element in the array
var number_player_image : Int = 0 //Number element of image array
var number_shut : Int = 0 //Number element of players shut
var score_record : Int = 0 //Your personal record
var soundflag : Bool = false

var gameinaction : Bool = false
//var showGameController : Bool = false
let playerArray = [UIImage(named:"Suttle_2-4"),
                   UIImage(named:"Suttle_4-4"),
                   UIImage(named:"Suttle_6-4")]
let imageArray = [UIColor(red:0.25, green:0.29, blue:0.29, alpha:1.0),
                  UIColor(red:0.47, green:0.47, blue:0.52, alpha:1.0),
                  UIColor(red:0.58, green:0.42, blue:0.52, alpha:1.0),
                  UIColor(red:0.46, green:0.66, blue:0.69, alpha:1.0),
                  UIColor(red:0.53, green:0.75, blue:0.58, alpha:1.0),
                  UIColor(red:0.75, green:0.73, blue:0.57, alpha:1.0)]
