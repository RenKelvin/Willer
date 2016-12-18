//
//  Deck.swift
//  Willer
//
//  Created by Chuan Ren on 10/27/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import UIKit

struct Deck {

    var name: String = "Deck:name"
    var massacre: Bool = false
    var sheriff: Bool = true

    var cards: [(Card, Int)] = []

    mutating func add(cards: [String: Int]) {
        for (id, num) in cards {
            self.cards.append((Card.factory(id: id), num))
        }
    }

}

// MARK: - Stored

extension Deck {

    static var deck_test: Deck {
        var deck = Deck()

        deck.name = "测试"
        deck.massacre = false

        deck.add(cards: [Constants.Werewolf: 3,
                         Constants.Townsfolk: 6,
                         Constants.Foreteller: 1,
                         Constants.Witch: 1,
                         Constants.Hunter: 1])

        return deck
    }

    // MARK: - 6

    static var deck_6_1: Deck {
        var deck = Deck()

        deck.name = "6人标准局"
        deck.massacre = true
        deck.sheriff = false

        deck.add(cards: [Constants.Werewolf: 2,
                         Constants.Townsfolk: 3,
                         Constants.Witch: 1])

        return deck
    }

    // MARK: - 7


    // MARK: - 8


    // MARK: - 9

    static var deck_9_1: Deck {
        var deck = Deck()

        deck.name = "饭局的诱惑"
        deck.massacre = false

        deck.add(cards: [Constants.Werewolf: 3,
                         Constants.Townsfolk: 3,
                         Constants.Foreteller: 1,
                         Constants.Witch: 1,
                         Constants.Hunter: 1])

        return deck
    }

    // MARK: - 10


    // MARK: - 11


    // MARK: - 12

    static var deck_12_1: Deck {
        var deck = Deck()

        deck.name = "Lying Man 标准局"
        deck.massacre = false

        deck.add(cards: [Constants.Werewolf: 4,
                         Constants.Townsfolk: 4,
                         Constants.Foreteller: 1,
                         Constants.Witch: 1,
                         Constants.Hunter: 1,
                         Constants.Idiot: 1])
        
        return deck
    }
    
    // MARK: - 13
    
    
    // MARK: - 14
    
    
    // MARK: - 15
    
    
    // MARK: - 16
    
}
