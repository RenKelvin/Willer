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
        var no = 1
        for (card, num) in deck.cards {
            for _ in 1...num {
                let player = Player(character: card.id, no: no)
                ProcessMidiator.sharedInstance.register(player: player)
                self.playerArray.append(player)
                no += 1
            }
        }
    }

    func settle() {
        for player in self.alivePlayers() {
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
