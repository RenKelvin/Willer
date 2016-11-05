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
        let p1 = Player(character: Constants.Werewolf, no: 1)
        ProcessMidiator.sharedInstance.register(player: p1)
        self.playerArray.append(p1)

        let p2 = Player(character: Constants.Witch, no: 2)
        ProcessMidiator.sharedInstance.register(player: p2)
        self.playerArray.append(p2)

        let p3 = Player(character: Constants.Townsfolk, no: 3)
        ProcessMidiator.sharedInstance.register(player: p3)
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
