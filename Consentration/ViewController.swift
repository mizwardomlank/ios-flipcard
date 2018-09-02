//
//  ViewController.swift
//  Consentration
//
//  Created by Miftah Mizwar on 9/2/18.
//  Copyright © 2018 Miftah Mac. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var flipCount = 0 {
        didSet{
            flipCountLabel.text = "Flips: \(flipCount)"
        }
    }
    
    var correctCount = 0
    
    var cardItems = ["🎓", "🍎", "🎧", "🎓", "❤️", "🎧", "🤡", "🍎",  "🐔", "🤡", "🐔", "❤️"]
    
    var firstCard, secondCard : String!
    var firstCardIndex, secondCardIndex : Int!
    var isCardSame = false;
    
    @IBOutlet var cardButtons: [UIButton]!
    
    @IBOutlet var flipCountLabel: UILabel!
    
    @IBAction func touchCard(_ sender: UIButton) {
        if let cardNumber = cardButtons.index(of: sender) {
            flipCard(withEmoji: cardItems[cardNumber], on: sender)
            sender.isEnabled = false
            
            if flipCount % 2 != 0 && flipCount >= 3 && isCardSame == false{
                cardButtons[firstCardIndex].isEnabled = true
                cardButtons[secondCardIndex].isEnabled = true
                
                cardButtons[firstCardIndex].setTitle("", for: UIControlState.normal)
                cardButtons[firstCardIndex].backgroundColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
                
                cardButtons[secondCardIndex].setTitle("", for: UIControlState.normal)
                cardButtons[secondCardIndex].backgroundColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
            }
            
            if (flipCount % 2 != 0){
                // first card
                firstCard = cardItems[cardNumber]
                firstCardIndex = cardNumber
            } else {
                // second card
                secondCard = cardItems[cardNumber]
                secondCardIndex = cardNumber
                
                // delay for shortime, to show image only
                
                // check when you open second card
                print ("\(firstCardIndex) and \(secondCardIndex)")
                if firstCard == secondCard {
                    isCardSame = true
                    
                    correctCount += 1
                    print ("\(correctCount)")
                    if correctCount == 6 {
                        let alert = UIAlertController(title: "Congratulation!", message: "Yey! you did it, you've flipped for \(flipCount) times", preferredStyle: UIAlertControllerStyle.alert)
                        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                        self.present(alert, animated: true, completion: nil)
                    }
                } else {
                    isCardSame = false
                }
            }
        } else {
            print ("choosen card was not in cardButtons")
        }
    }
    
    @IBAction func touchRestart(_ sender: UIButton) {
        // looping all card to closed state
        var i = 0;
        for cardButton in cardButtons {
            cardButton.setTitle("", for: UIControlState.normal)
            cardButton.backgroundColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
            
            cardButtons[i].isEnabled = true
            i += 1
        }
        
        flipCount = 0
        correctCount = 0
        cardItems = shuffled(withItems: cardItems)
    }
    
    func flipCard(withEmoji emoticon: String, on button: UIButton){
        
        flipCount += 1

        if button.currentTitle == emoticon {
            button.setTitle("", for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 0.2605174184, green: 0.2605243921, blue: 0.260520637, alpha: 1)
        } else {
            button.setTitle(emoticon, for: UIControlState.normal)
            button.backgroundColor = #colorLiteral(red: 1, green: 0.4081628051, blue: 0.446774744, alpha: 1)
        }
    }

    func shuffled(withItems items : Array<String>) -> Array<String>{
        
        var items = items;
        var shuffled = [String]();
        
        for _ in 0..<items.count
        {
            let rand = Int(arc4random_uniform(UInt32(items.count)))
            
            shuffled.append(items[rand])
            
            items.remove(at: rand)
        }

        return shuffled;
    }
}

