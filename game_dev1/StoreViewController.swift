//
//  ViewController.swift
//  game_dev1
//
//  Created by Дмитрий on 14.07.16.
//  Copyright © 2016 Дмитрий. All rights reserved.
//

import UIKit

class StoreViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private let selected_text : String = "Selected"
    private let select_text : String = "Tap to save"
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var imageViewBackground: UIImageView!
    @IBOutlet weak var imageViewShut: UIImageView!
    @IBOutlet weak var selected: UIButton!
    @IBOutlet weak var selectView: UIView!
    @IBOutlet weak var selectShutView: UIView!
    
    @IBAction func selectTap(sender: AnyObject) {
        selectedSet()
    }
    @IBAction func selectButton(sender: AnyObject) {
        selectedSet()
    }
    
    @IBAction func leftShut(sender: AnyObject) {
        if (number_shut>0)&&(number_shut<imageShoot.count){
            number_shut -= 1
            imageViewShut.image = imageShoot[number_shut]
        } else {
            number_shut = imageShoot.count-1
            imageViewShut.image = imageShoot[number_shut]
        }
        selectedReset()
    }
    
    @IBAction func rightShut(sender: AnyObject) {
        if (number_shut>=0)&&(number_shut<imageShoot.count-1){
            number_shut += 1
            imageViewShut.image = imageShoot[number_shut]
        } else {
            number_shut = 0
            imageViewShut.image = imageShoot[number_shut]
        }
        selectedReset()
    }
    
    @IBAction func leftImage(sender: AnyObject) {
        if (number_player_image>0)&&(number_player_image<playerArray.count){
            number_player_image -= 1
            imageView.image = playerArray[number_player_image]
        } else {
            number_player_image = playerArray.count-1
            imageView.image = playerArray[number_player_image]
        }
        selectedReset()
    }
    
    @IBAction func rightImage(sender: AnyObject) {
        if (number_player_image>=0)&&(number_player_image<playerArray.count-1){
            number_player_image += 1
            imageView.image = playerArray[number_player_image]
        } else {
            number_player_image = 0
            imageView.image = playerArray[number_player_image]
        }
        selectedReset()
    }
    
    private func selectedSet() {
        selected.setTitle(selected_text, forState: .Normal)
        selected.setTitleColor(UIColor(red:0.70, green:0.13, blue:0.13, alpha:1.0), forState: .Normal)
        selectView.backgroundColor = UIColor(red:0.70, green:0.13, blue:0.13, alpha:1.0)
        selectShutView.backgroundColor = UIColor(red:0.70, green:0.13, blue:0.13, alpha:1.0)
        
        let defaults = NSUserDefaults.standardUserDefaults()
        defaults.setInteger(number_shut, forKey: "NumberShutImage")
        defaults.setInteger(number_background, forKey: "BackGameScene")
        defaults.setInteger(number_player_image, forKey: "NumberPlayerImage")
        defaults.synchronize()
    }
    
    private func selectedReset() {
        selected.setTitle(select_text, forState: .Normal)
        selected.setTitleColor(UIColor.whiteColor(), forState: .Normal)
        selectView.backgroundColor = nil
        selectShutView.backgroundColor = nil
    }
    
    override func viewDidLoad() {
        imageView.image = playerArray[number_player_image]
        imageViewBackground.backgroundColor = imageArray[number_background]
        imageViewShut.image = imageShoot[number_shut]
        imageViewShut.backgroundColor = imageArray[number_background]
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return imageArray.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("cell", forIndexPath: indexPath) as! CollectionViewCell
        cell.imageView?.backgroundColor = imageArray[indexPath.row]
        return cell
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        number_background=indexPath.row
        imageViewBackground.backgroundColor = imageArray[number_background]
        imageViewShut.backgroundColor = imageArray[number_background]
        selectedReset()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    /* //ТИПА ПО ЦЕНТРУ)
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAtIndex seсction: Int) -> UIEdgeInsets {
        
        let totalCellWidth = 100 * self.imageArray.count
        let totalSpacingWidth = 10 * (self.imageArray.count - 1)
        
        let leftInset = (CGFloat(totalCellWidth + totalSpacingWidth)-100) / 2;
        let rightInset = leftInset
        
        return UIEdgeInsetsMake(0, leftInset, 0, rightInset)
    }
    */
}
