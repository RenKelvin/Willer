//
//  EffectMachine.swift
//  Willer
//
//  Created by Chuan Ren on 11/4/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import UIKit

class EffectMachine: NSObject {

    var effects: Set<Effect> = []

    func attachEffect(effect: Effect) {
        self.effects.insert(effect)
    }

    func effectString() -> String {
        var str = "E: "

        for effect in self.effects {
            str += effect.id + " "
        }

        return str

    }

    func settle() -> Bool {
        if self.isWerewolfKilled() {
            return false
        }

        return true
    }

    func isWerewolfKilled() -> Bool {
        let effect = Effect(id: "werewolf_kill_effect")

        return self.effects.contains(effect)
    }
    
}
