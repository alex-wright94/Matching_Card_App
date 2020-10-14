//
//  CardModel.swift
//  MatchingCardapp
//
//  Created by Alex Wright on 5/13/20.
//  Copyright © 2020 Alex Wright. All rights reserved.
//

import Foundation


class CardModel {
    
    func getCards() -> [Card] {
        
//        declare an empty array to store numbers that have been generated already
        var generatedNumbers = [Int]()
        
        
        //declare an empty array to store cards
        var generatedCards = [Card]()
        
        
        
        
        
//        randomly generate 8 pairs of cards
        while generatedNumbers.count < 8 {
//            generate a random number
            let randomNumber = Int.random(in: 1...13)
            
            if generatedNumbers.contains(randomNumber) == false {
                
                
                //            create two new card objects
                let cardOne = Card()
                let cardTwo = Card()
                
                //            set their image names
                cardOne.imageName = "card\(randomNumber)"
                cardTwo.imageName = "card\(randomNumber)"
                //            add them to the array
                generatedCards += [cardOne, cardTwo]
                
//                add this number to the list of generated numbers
                generatedNumbers.append(randomNumber)
                
                
                print(randomNumber)
                
            }
            
        }
//        randomize cards
        generatedCards.shuffle()
        
        
//        return array
        return generatedCards
    }
}

