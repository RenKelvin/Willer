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

    static let shared = PlayerMidiator()

    override private init() {

    }

    func generatePlayers(deck: Deck) {
        self.playerArray.removeAll()

        var no = 1
        for (card, num) in deck.cards {
            for _ in 1...num {
                let player = Player(character: card.id, no: no)
                ProcessMidiator.shared.register(player: player)
                self.playerArray.append(player)
                no += 1
            }
        }
    }

    func generatePlayers(cards: [Card]) {
        self.playerArray.removeAll()

        var no = 1
        for card: Card in cards {
            let player = Player(character: card.id, no: no)
            ProcessMidiator.shared.register(player: player)
            self.playerArray.append(player)
            no += 1
        }
    }

    func settle() {
        for player in self.livingPlayers() {
            player.settle()
        }
    }

    func selectPlayer(at index: Int) {
        let player = PlayerMidiator.shared.livingPlayers()[index]

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
            self.selectedPlayers.remove(at: self.selectedPlayers.firstIndex(of: player)!)
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

    func livingPlayers() -> [Player]
    {
        return self.playerArray.filter({$0.stateMachine.living})
    }

    func livePlayers() -> [Player]
    {
        return self.playerArray.filter({$0.stateMachine.state == .live})
    }

    func werewolfKilledPlayers() -> [Player]
    {
        return self.livePlayers().filter({$0.effectMachine.isWerewolfKilled()})
    }

    func dyingPlayers() -> [Player]
    {
        return self.playerArray.filter({$0.stateMachine.state == .dying})
    }

    // MARK: - Winning checks

    func isWerewolfWiped() -> Bool {
        return self.livePlayers().filter({$0.character.isWerewolf()}).isEmpty
    }

    func isTownsfolkWiped() -> Bool {
        return self.livePlayers().filter({$0.character.isTownsfolk()}).isEmpty
    }

    func isPriesthoodWiped() -> Bool {
        return self.livePlayers().filter({$0.character.isPriesthood()}).isEmpty
    }
    
}
