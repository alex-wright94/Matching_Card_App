//
//  CardCollectionVewCell.swift
//  MatchingCardapp
//
//  Created by Alex Wright on 5/13/20.
//  Copyright © 2020 Alex Wright. All rights reserved.
//

import UIKit

class CardCollectionVewCell: UICollectionViewCell {
    
    
    @IBOutlet weak var frontimageview: UIImageView!
    
    
    
    @IBOutlet weak var backimageview: UIImageView!
    
    
    var card:Card?



    func configureCell(card:Card) {
        
        
//        keep track of the card this cell represents
        self.card = card
        
        
//        set front image view to the image that represents the card
        frontimageview.image = UIImage(named: card.imageName)
        
        
//        reset the state of the cell by checking the flipped status of the card and then showing the front or back imageview accordingly
        
        
        if card.isMatched == true {
            backimageview.alpha = 0
            frontimageview.alpha = 0
            return
        }
        else {
            backimageview.alpha = 1
            frontimageview.alpha = 1
        }
        
        
        if card.isFlipped == true {
//            show the frontimage view
            flipUp(speed: 0)
        }
        else {
//            show the back image view
            flipDown(speed: 0, delay: 0)
        }
    }
    func flipUp(speed:TimeInterval = 0.3) {
//        flip up animation
        UIView.transition(from: backimageview, to: frontimageview, duration:speed, options: [.showHideTransitionViews,.transitionFlipFromLeft], completion: nil)
        
        
//        set the status of the card
        card?.isFlipped = true
    }
    
    func flipDown(speed:TimeInterval = 0.3, delay:TimeInterval = 0.5) {
        
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 0.5) {
            //        flip down animation
            UIView.transition(from: self.frontimageview, to: self.backimageview, duration:speed, options: [.showHideTransitionViews,.transitionFlipFromLeft], completion: nil)
            
            
        }
        
        
//        set the status of the card
        
        card?.isFlipped = false

    }
    
    func remove() {
//        make the image views invisible
        backimageview.alpha = 0
        
        
        UIView.animate(withDuration: 0.3, delay: 0.5, options: .curveEaseOut, animations: {
            
            self.frontimageview.alpha = 0
            
        }, completion: nil)
    }
    
    
    
    
}
