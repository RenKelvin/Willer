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
    }

}
