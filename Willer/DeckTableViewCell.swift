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
    }

}
