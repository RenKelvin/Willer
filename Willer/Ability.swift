//
//  Ability.swift
//  Willer
//
//  Created by Chuan Ren on 10/28/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import UIKit

class Ability: NSObject {

    weak var player: Player?

    var id: String = "Ability:id"

    var passive: Bool?

    var cooldown = 9999
    var lastCast = -9999

    var maxSelected: Int = 0

    var modifiers: [Modifier] = []


    // MARK: -

    func perform() -> Bool {
        var rst = true
        for modifier in modifiers {
            rst = modifier.modify() && rst
        }
        return rst
    }

    // MARK: -

    func preAction() {
        PlayerMidiator.sharedInstance.maxSelected = self.maxSelected
    }

    func action() -> Bool {
        if !self.avalaible() {
            return false
        }

        let rst = self.perform()
        if rst {
            self.lastCast = StatusMidiator.sharedInstance.currentDay
        }
        return rst
    }

    func posAction() {

    }

    func step() -> Step {
        let step = Step()

        step.headText = "Ability:headText"
        step.bodyText = "Ability:bodyText"

        step.firstActionText = "Ability:firstActionText"
        step.secondActionText = "Ability:secondActionText"

        step.preAction = self.preAction
        step.posAction = self.posAction

        return step
    }

    // MARK: -

    func ingest(player: Player) {
        self.player = player
        for modifier in self.modifiers {
            modifier.ingest(player: player)
        }
    }

    func avalaible() -> Bool {
        return StatusMidiator.sharedInstance.currentDay - self.lastCast > self.cooldown
    }
    
}
