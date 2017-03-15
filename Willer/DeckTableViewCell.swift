//
//  DeckTableViewCell.swift
//  Willer
//
//  Created by Chuan Ren on 12/10/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import UIKit

class DeckTableViewCell: UITableViewCell {

    @IBOutlet var nameLabel: UILabel!
    @IBOutlet var infoLabel: UILabel!
    @IBOutlet var charactersLabel: UILabel!

    @IBOutlet var cardView: UIView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func config(deck: Deck) {
        self.nameLabel.text = deck.name

        //
        var infoString = ""
        if deck.massacre {
            infoString += "屠城"
        }
        else {
            infoString += "屠边"
        }

        infoString += " "

        if deck.sheriff {
            infoString += "有警长"
        }
        else {
            infoString += "无警长"
        }

        self.infoLabel.text = infoString

        //
        var charString = ""
        for (card, num) in deck.cards {
            charString += " " + card.name + "*" + String(num)
        }

        self.charactersLabel.text = charString

        self.cardView.layer.cornerRadius = 3.0
        self.cardView.layer.shadowRadius = 4.0
        self.cardView.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        self.cardView.layer.shadowColor = UIColor.black.cgColor
        self.cardView.layer.shadowOpacity = 0.1
    }

}
