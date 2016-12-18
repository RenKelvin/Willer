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

    static var deck_7_1: Deck {
        var deck = Deck()

        deck.name = "7人标准局"
        deck.massacre = true
        deck.sheriff = false

        deck.add(cards: [Constants.Werewolf: 2,
                         Constants.Townsfolk: 4,
                         Constants.Witch: 1])

        return deck
    }

    // MARK: - 8

    static var deck_8_1: Deck {
        var deck = Deck()

        deck.name = "8人标准局 1"
        deck.massacre = true
        deck.sheriff = true

        deck.add(cards: [Constants.Werewolf: 2,
                         Constants.Townsfolk: 5,
                         Constants.Witch: 1])

        return deck
    }

    static var deck_8_2: Deck {
        var deck = Deck()

        deck.name = "8人标准局 2"
        deck.massacre = false
        deck.sheriff = true

        deck.add(cards: [Constants.Werewolf: 2,
                         Constants.Townsfolk: 4,
                         Constants.Witch: 1,
                         Constants.Idiot: 1])

        return deck
    }

    static var deck_8_3: Deck {
        var deck = Deck()

        deck.name = "8人标准局 3"
        deck.massacre = false
        deck.sheriff = true

        deck.add(cards: [Constants.Werewolf: 3,
                         Constants.Townsfolk: 3,
                         Constants.Foreteller: 1,
                         Constants.Witch: 1])

        return deck
    }

    // MARK: - 9

    static var deck_9_1: Deck {
        var deck = Deck()

        deck.name = "饭局的诱惑 无警长"
        deck.massacre = false
        deck.sheriff = false

        deck.add(cards: [Constants.Werewolf: 3,
                         Constants.Townsfolk: 3,
                         Constants.Foreteller: 1,
                         Constants.Witch: 1,
                         Constants.Hunter: 1])

        return deck
    }

    static var deck_9_2: Deck {
        var deck = Deck()

        deck.name = "饭局的诱惑 有警长"
        deck.massacre = false
        deck.sheriff = true

        deck.add(cards: [Constants.Werewolf: 3,
                         Constants.Townsfolk: 3,
                         Constants.Foreteller: 1,
                         Constants.Witch: 1,
                         Constants.Hunter: 1])

        return deck
    }

    static var deck_9_3: Deck {
        var deck = Deck()

        deck.name = "9人屠城局"
        deck.massacre = true
        deck.sheriff = true

        deck.add(cards: [Constants.Werewolf: 2,
                         Constants.Townsfolk: 5,
                         Constants.Foreteller: 1,
                         Constants.Witch: 1])

        return deck
    }

    // MARK: - 10

    static var deck_10_1: Deck {
        var deck = Deck()

        deck.name = "10人标准局"
        deck.massacre = false
        deck.sheriff = true

        deck.add(cards: [Constants.Werewolf: 3,
                         Constants.Townsfolk: 4,
                         Constants.Foreteller: 1,
                         Constants.Witch: 1,
                         Constants.Hunter: 1])

        return deck
    }

    // MARK: - 11

    static var deck_11_1: Deck {
        var deck = Deck()

        deck.name = "11人标准局"
        deck.massacre = true
        deck.sheriff = true

        deck.add(cards: [Constants.Werewolf: 4,
                         Constants.Townsfolk: 4,
                         Constants.Foreteller: 1,
                         Constants.Witch: 1,
                         Constants.Hunter: 1])

        return deck
    }

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
    
}
