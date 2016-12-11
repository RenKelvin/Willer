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
        case 9:
            return [Deck.deck_9_1, Deck.deck_9_1]
        default:
            return [Deck.deck_test]
        }
    }
    
}
