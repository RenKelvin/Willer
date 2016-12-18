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
            return [Deck.deck_6_1]
        case 8:
            return [Deck.deck_6_1]
        case 9:
            return [Deck.deck_9_1]
        case 10:
            return [Deck.deck_6_1]
        case 11:
            return [Deck.deck_6_1]
        case 12:
            return [Deck.deck_12_1]
        case 13:
            return [Deck.deck_12_1]
        case 14:
            return [Deck.deck_12_1]
        case 15:
            return [Deck.deck_12_1]
        case 16:
            return [Deck.deck_12_1]
        default:
            return [Deck.deck_test]
        }
    }
    
}
