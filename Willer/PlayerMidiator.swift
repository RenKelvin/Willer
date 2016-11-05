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

    var alivePlayers: [Player] { return self.playerArray }

    var maxSelected: Int = 1
    var selectedPlayers: [Player] = []

    // MARK: - Singleton

    static let sharedInstance = PlayerMidiator()

    override private init() {

    }

    func generatePlayers(deck: Deck) {
        let p1 = Player()
        p1.no = 1
        p1.character = Werewolf()
        self.playerArray.append(p1)

        let p2 = Player()
        p2.no = 2
        p2.character = Werewolf()
        self.playerArray.append(p2)

        let p3 = Player()
        p3.no = 3
        p3.character = Werewolf()
        self.playerArray.append(p3)

        //        let p4 = Player(id: "townsfolk")
        //        p4.no = 4
        //        self.playerArray.append(p4)
        //
        //        let p5 = Player(id: "townsfolk")
        //        p5.no = 5
        //        self.playerArray.append(p5)
        //
        //        let p6 = Player(id: "townsfolk")
        //        p6.no = 6
        //        self.playerArray.append(p6)
    }

    func settle() {

    }

    func selectPlayer(at index: Int) {
        let player = PlayerMidiator.sharedInstance.alivePlayers[index]

        if (!player.selected) {
            player.selected = true
            self.selectedPlayers.append(player)

            if self.selectedPlayers.count > self.maxSelected {
                let deselectedPlayer = self.selectedPlayers.first
                deselectedPlayer?.selected = false

                self.selectedPlayers = Array(self.selectedPlayers.dropFirst())
            }
        }
        else {
            player.selected = false
            self.selectedPlayers.remove(at: self.selectedPlayers.index(of: player)!)
        }
    }

    func cleanSelectedPlayers() {
        for player in self.selectedPlayers {
            player.selected = false
        }
        self.selectedPlayers.removeAll()
        self.maxSelected = 0
    }
    
}
