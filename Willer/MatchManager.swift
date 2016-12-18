//
//  MatchManager.swift
//  Willer
//
//  Created by Chuan Ren on 10/27/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import UIKit

class MatchManager: NSObject {

    // MARK: - Singleton

    static let shared = MatchManager()

    override private init() {

    }

    func decks(for num: Int) -> [Deck] {
        switch num {
        case 6:
            return [Deck.deck_6_1]
        case 7:
            return [Deck.deck_7_1]
        case 8:
            return [Deck.deck_8_1, Deck.deck_8_2, Deck.deck_8_3]
        case 9:
            return [Deck.deck_9_1, Deck.deck_9_2, Deck.deck_9_3]
        case 10:
            return [Deck.deck_10_1]
        case 11:
            return [Deck.deck_11_1]
        case 12:
            return [Deck.deck_12_1]
        default:
            return [Deck.deck_test]
        }
    }
    
}
