//
//  Deck.swift
//  Willer
//
//  Created by Chuan Ren on 10/27/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import UIKit

struct Deck {

    var name: String = ""

    var cards: [(Card, Int)] = []

    init() {

    }

    init(name: String, cards: [String: Int]) {
        self.name = name
        for (id, num) in cards {
            self.cards.append((Card(id: id), num))
        }
    }

}

// MARK: -

extension Deck {

    static var deck_test: Deck {
        return Deck(name: "测试",
                    cards: [Constants.Werewolf: 3,
                            Constants.Townsfolk: 6,
                            Constants.Foreteller: 1,
                            Constants.Witch: 1,
                            Constants.Hunter: 1])
    }

    // MARK: - 4

    static var deck_4_1: Deck {
        return Deck.deck_test
    }

    // MARK: - 5


    // MARK: - 6


    // MARK: - 7


    // MARK: - 8


    // MARK: - 9

    static var deck_9_1: Deck {
        return Deck(name: "饭局的诱惑",
                    cards: [Constants.Werewolf: 3,
                            Constants.Townsfolk: 3,
                            Constants.Foreteller: 1,
                            Constants.Witch: 1,
                            Constants.Hunter: 1])
    }

    // MARK: - 10


    // MARK: - 11


    // MARK: - 12


    // MARK: - 13
    
    
    // MARK: - 14
    
    
    // MARK: - 15
    
    
    // MARK: - 16
    
}
