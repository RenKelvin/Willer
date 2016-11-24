//
//  Modifier.swift
//  Willer
//
//  Created by Chuan Ren on 10/28/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import UIKit

class Modifier: NSObject {

    weak var player: Player?

    var id: String = "Modifier:id"

    var targetAmount = 0

    func modify() -> Bool {
        return true
    }

    func attachEffect(effect: Effect, targets: [Player]) {
        var e = effect
        e.attached = StatusMidiator.shared.currentDay

        for target in targets {
            target.effectMachine.attachEffect(effect: e)
        }
    }

    func takeEffect(effect: Effect, targets: [Player]) {
        var e = effect
        e.attached = StatusMidiator.shared.currentDay

        for target in targets {
            target.effectMachine.attachEffect(effect: e)
            target.settle()
        }
    }

    func ingest(player: Player) {
        self.player = player
    }

}
