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

    var maxSelected: Int = 0
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
        p2.character = Witch()
        self.playerArray.append(p2)

        let p3 = Player()
        p3.no = 3
        p3.character = Townsfolk()
        self.playerArray.append(p3)
    }

    func settle() {
        for player in self.playerArray {
            player.settle()
        }
    }

    func selectPlayer(at index: Int) {
        let player = PlayerMidiator.sharedInstance.alivePlayers()[index]

        if (!player.stateMachine.selected) {
            player.stateMachine.selected = true
            self.selectedPlayers.append(player)

            if self.selectedPlayers.count > self.maxSelected {
                let deselectedPlayer = self.selectedPlayers.first
                deselectedPlayer?.stateMachine.selected = false

                self.selectedPlayers = Array(self.selectedPlayers.dropFirst())
            }
        }
        else {
            player.stateMachine.selected = false
            self.selectedPlayers.remove(at: self.selectedPlayers.index(of: player)!)
        }
    }

    func cleanSelectedPlayers() {
        for player in self.selectedPlayers {
            player.stateMachine.selected = false
        }
        self.selectedPlayers.removeAll()
        self.maxSelected = 0
    }

    // Mark: -

    func alivePlayers() -> [Player]
    {
        return self.playerArray.filter({$0.stateMachine.alive})
    }

    func werewolfKilledPlayers() -> [Player]
    {
        return self.alivePlayers().filter({$0.effectMachine.isWerewolfKilled()})
    }
    
}
