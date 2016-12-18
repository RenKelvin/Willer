//
//  GameManager.swift
//  Willer
//
//  Created by Chuan Ren on 10/28/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import UIKit

class GameManager: NSObject {

    var deck: Deck?

    // MARK: - Singleton

    static let shared = GameManager()

    override private init() {

    }

    // MARK: - Update game view controller

    func updateViewController() {
        NotificationCenter.default.post(name: NSNotification.Name("OnUpdate"), object: nil)
    }

    // MARK: - Pick

    func start(deck: Deck) {
        PlayerMidiator.shared.generatePlayers(deck: deck)
    }

    func start(cards: [Card]) {
        StatusMidiator.shared.currentDay = 0
        ProcessMidiator.shared.stepQueue = []
        PlayerMidiator.shared.generatePlayers(cards: cards)
    }

    // MARK: - Game

    func zeroDay() {
        // Process
        ProcessMidiator.shared.reload()

        //
        self.updateViewController()
    }

    func nextDay() {

        // Player
        PlayerMidiator.shared.settle()

        // Status
        StatusMidiator.shared.alternate()

        // Process
        ProcessMidiator.shared.reload()

        //
        self.updateViewController()
    }

    func nextStep() {
        //
        PlayerMidiator.shared.cleanSelectedPlayers()

        //
        ProcessMidiator.shared.nextStep()

        //
        self.updateViewController()
    }

    // MARK: -

    func currentDay() -> Int {
        return StatusMidiator.shared.currentDay
    }

    func currentStep() -> Step? {
        return ProcessMidiator.shared.currentStep
    }

    func firstAction() {
        let result = ProcessMidiator.shared.currentStep?.firstAction?()
        if result != nil && result! {
            self.nextStep()
        }
    }

    func secondAction() {
        let result = ProcessMidiator.shared.currentStep?.secondAction?()
        if result != nil && result! {
            self.nextStep()
        }
    }

    func livingPlayers() -> [Player] {
        return PlayerMidiator.shared.livingPlayers()
    }

    func selectPlayer(at index: Int) {
        PlayerMidiator.shared.selectPlayer(at: index)

        //
        self.updateViewController()
    }

    // MARK: -

    func win() -> String? {
        if (self.deck?.massacre)! {
            if (PlayerMidiator.shared.isWerewolfWiped()) {
                return "好人获胜！"
            }
            else if (PlayerMidiator.shared.isTownsfolkWiped() && PlayerMidiator.shared.isPriesthoodWiped()) {
                return "狼人获胜！"
            }
            else {
                return nil
            }
        }
        else {
            if (PlayerMidiator.shared.isWerewolfWiped()) {
                return "好人获胜！"
            }
            else if (PlayerMidiator.shared.isTownsfolkWiped() || PlayerMidiator.shared.isPriesthoodWiped()) {
                return "狼人获胜！"
            }
            else {
                return nil
            }
        }
    }
}
