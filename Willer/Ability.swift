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

    var maxSelected: Int = 0

    var modifiers: [Modifier] = []


    // MARK: -

    func perform() {
        for modifier in modifiers {
            modifier.modify()
        }
    }

    func preAction() {
        PlayerMidiator.sharedInstance.maxSelected = self.maxSelected
    }

    func action() -> Bool {
        self.perform()

        return true
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

    func ingest(player: Player) {
        self.player = player
        for modifier in self.modifiers {
            modifier.ingest(player: player)
        }
    }
    
}
