//
//  Deck.swift
//  Willer
//
//  Created by Chuan Ren on 10/27/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import UIKit

class Deck: NSObject {

    var cards: [(Card, Int)] = []

    static func testDeck() -> Deck {
        let deck = Deck()

        deck.cards.append((Card(id: Constants.Werewolf), 3))
        deck.cards.append((Card(id: Constants.Townsfolk), 3+3))
        deck.cards.append((Card(id: Constants.Foreteller), 1))
        deck.cards.append((Card(id: Constants.Witch), 1))
        deck.cards.append((Card(id: Constants.Hunter), 1))

        return deck
    }
    
}
