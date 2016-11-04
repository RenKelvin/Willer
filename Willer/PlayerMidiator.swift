//
//  PlayerMidiator.swift
//  Willer
//
//  Created by Chuan Ren on 10/29/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import UIKit

class PlayerMidiator: NSObject {

    var playerArray = [Player]()

    // MARK: - Singleton

    static let sharedInstance = PlayerMidiator()

    override private init() {
        print("123")
    }

    func generatePlayers(deck: Deck) {
        let p1 = Player(id: "townsfolk")
        p1.no = 1
        self.playerArray.append(p1)

        let p2 = Player(id: "werewolf")
        p2.no = 2
        self.playerArray.append(p2)

        let p3 = Player(id: "witch")
        p3.no = 3
        self.playerArray.append(p3)
    }

    func settle() {

    }

    func alivePlayers() -> [Player] {
        return self.playerArray
    }
    
}
