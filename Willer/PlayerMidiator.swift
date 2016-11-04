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

    var alivePlayers: [Player] {
        return self.playerArray
    }

    // MARK: - Singleton

    static let sharedInstance = PlayerMidiator()

    override private init() {

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

        let p4 = Player(id: "townsfolk")
        p4.no = 4
        self.playerArray.append(p4)

        let p5 = Player(id: "townsfolk")
        p5.no = 5
        self.playerArray.append(p5)

        let p6 = Player(id: "townsfolk")
        p6.no = 6
        self.playerArray.append(p6)
    }
    
    func settle() {
        
    }
}
