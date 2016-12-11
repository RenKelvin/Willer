//
//  PickViewController.swift
//  Willer
//
//  Created by Chuan Ren on 10/27/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import UIKit

class PickViewController: UIViewController {

    var deck: Deck?
    var shuffledCards: [Card] = []

    var index: Int = 0
    var hidden: Bool = true

    @IBOutlet var titleLabel: UILabel!

    @IBOutlet var cardImageView: UIImageView!
    @IBOutlet var cardNameLabel: UILabel!
    @IBOutlet var cardSloganLabel: UILabel!

    @IBOutlet var mainButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        for (card, num) in self.deck!.cards {
            for _ in 0..<num {
                self.shuffledCards.append(card)
            }
        }
        self.shuffledCards.shuffle()

        self.update()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func update() {
        // Hidden
        if hidden {
            self.titleLabel.text = "\(index+1)号玩家请看牌"

            self.cardImageView.image = UIImage(named: "card_cover")
            self.cardNameLabel.text = ""
            self.cardSloganLabel.text = ""

            self.mainButton.setTitle("显示身份", for: .normal)
        }
            // Revealed
        else {
            self.titleLabel.text = "你的身份是"

            let card = self.shuffledCards[index]
            self.cardImageView.image = UIImage(named: "card_foreteller")
            self.cardNameLabel.text = card.id
            self.cardSloganLabel.text = ""

            self.mainButton.setTitle("知道了", for: .normal)
        }

        // Last one
        if hidden == false && index == self.shuffledCards.count-1 {
            self.mainButton.setTitle("开始游戏", for: .normal)
        }
    }

    @IBAction func buttonTap() {
        // Last one
        if hidden == false && index == self.shuffledCards.count-1 {
            self.performSegue(withIdentifier: "PickGameSegueIdentifier", sender: nil)
        }
            // Or update
        else {
            if self.hidden {
                self.hidden = false
            }
            else {
                self.hidden = true
                self.index += 1
            }
            self.update()
        }
    }

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        let destination = segue.destination as! GameViewController
        destination.deck = self.deck
    }

}

extension Array
{
    /** Randomizes the order of an array's elements. */
    mutating func shuffle()
    {
        for _ in 0..<10
        {
            sort { (_,_) in arc4random() < arc4random() }
        }
    }
}
