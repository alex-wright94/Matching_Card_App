//
//  ViewController.swift
//  MatchingCardapp
//
//  Created by Alex Wright on 5/12/20.
//  Copyright © 2020 Alex Wright. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
   
    @IBOutlet weak var collectionView: UICollectionView!
    
    
    @IBOutlet weak var timerLabel: UILabel!
    
    
    let model = CardModel()
    var cardsArray = [Card]()
    
    var timer:Timer?
    var milliseconds:Int = 40 * 1000
    
    
    var firstFlippedCardIndex:IndexPath?
    
    var soundPlayer = SoundManager()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        
        cardsArray = model.getCards()
        
//        set the view controller as the data source and delegate of the collection view
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        
//        initialize the timer
        timer = Timer.scheduledTimer(timeInterval: 0.001, target: self, selector: #selector(timerFired), userInfo: nil, repeats: true)
        RunLoop.main.add(timer!, forMode: .common)
        
    }
    override func viewDidAppear(_ animated: Bool) {
//        shuffle sound here
        soundPlayer.PlaySound(effect: .shuffle)
    }
    
//    MARK: - timer methods
    
    @objc func timerFired(){
//        decrement the counter
        milliseconds -= 1
//        update the timer label
        let seconds:Double = Double(milliseconds)/1000.0
        timerLabel.text = String(format: "Time Remaining:%.2f", seconds)
//        stop the timer if it reaches zero
        if milliseconds == 0 {
            timerLabel.textColor = UIColor.red
            timer?.invalidate()
            
//            check if the user has cleared all the pairs
            checkForGameEnd()
        }
        
    }
    
    
//    MARK: - Collection View Delegate Methods
    
     func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
    //        return number of cards
            return cardsArray.count
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
    //        get a cell
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CardCell", for: indexPath) as! CardCollectionVewCell
            
            
    //        return cell
            return cell
            
            }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
//        configure the state of the cell based on the properties of the card it represents
        let cardCell = cell as? CardCollectionVewCell
         
        //            get the card from the card array
                    let card = cardsArray[indexPath.row]
                    
            //        Configure cell
                    cardCell?.configureCell(card: card)
                        }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
//        check if theres any time left. dont let the user interact if its 0
        if milliseconds <= 0 {
            return
        }
        
        
//        get a reference to the cell that was tapped
        let cell = collectionView.cellForItem(at: indexPath) as? CardCollectionVewCell
        
        
//        check the status of the card to determine how to flip it
        if cell?.card?.isFlipped == false && cell?.card?.isMatched == false  {
            
            //        flip the card up
            cell?.flipUp()
            
            
//            play sound
            soundPlayer.PlaySound(effect: .flip)
            
//            check ot see if this is the first or second card flipped
            if firstFlippedCardIndex == nil {
//                this is the first card flipped
                
                firstFlippedCardIndex = indexPath
                
            }
            else {
//                this is the second card flipped
                
//                run comparison logic
                checkForMatch(indexPath)
            }
        }
        
        
    }
    
//    MARK: - Game logic methods
    func checkForMatch(_ secondFlippedCardIndex:IndexPath) {
        
        
//        get the two card objects for the two indices and see if they match
        
        let cardOne = cardsArray[firstFlippedCardIndex!.row]
        let cardTwo = cardsArray[secondFlippedCardIndex.row]
        
        
//        get the view cells that represent card 1 and 2
        let cardOneCell = collectionView.cellForItem(at: firstFlippedCardIndex!) as? CardCollectionVewCell
        
        let cardTwoCell = collectionView.cellForItem(at: secondFlippedCardIndex) as? CardCollectionVewCell
        
//        compare the two cards
        if cardOne.imageName == cardTwo.imageName {
            
            
//            its a match
            
//            play match sound
            soundPlayer.PlaySound(effect: .match)
            
//            set the status and remove them
            cardOne.isMatched = true
            cardTwo.isMatched = true
            
            cardOneCell?.remove()
            cardTwoCell?.remove()
            
            
            
//            was that the last pair?
            checkForGameEnd()        }
        else{
            
            
//            play non match sound
            soundPlayer.PlaySound(effect: .nomatch)
//            its not a match
            cardOne.isFlipped = false
            cardTwo.isFlipped = false
            
//            flip them back over
            cardOneCell?.flipDown()
            cardTwoCell?.flipDown()
        }
        
//        reset the firstflipped card index property
        firstFlippedCardIndex = nil
        
    }
    func checkForGameEnd(){
//        check if there is unmatched cards
//        assume the user has won and check cards to see if matched
        
        var hasWon = true
        
        for card in cardsArray{
            if card.isMatched == false{
                hasWon = false
                break
            }
        }
        if hasWon == true{
//            user has won show an alert
            showAlert(title: "Congatulations!", message: "You Win!")
            
        }
        else{
//            user hasnt won yet check if theres time left
            if milliseconds <= 0 {
                showAlert(title: "Time is Up!", message: "Try Again")
            }
        }
    }
    
    func showAlert(title:String, message:String){
        
//        create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
//        add a button for the user to dismiss alert
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(okAction)
        
//        show the alert
        present(alert, animated: true, completion: nil)
    }
}

