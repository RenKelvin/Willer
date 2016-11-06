//
//  Werewolf.swift
//  Willer
//
//  Created by Chuan Ren on 11/4/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import UIKit

class Werewolf: Character {

    override init() {
        super.init()

        self.id = "Werewolf"
        self.name = "狼人"

        self.abilities = [werewolf_kill_ability()]
    }

}

// MARK: - Kill

class werewolf_kill_ability: Ability {

    override init() {
        super.init()

        self.id = Constants.werewolf_kill_ability

        self.cooldown = 1

        self.maxSelected = 1

        self.modifiers = [werewolf_kill_modifier()]
    }

    override func step() -> Step {
        let step = super.step()

        step.headText = "狼人回合"
        step.bodyText = "1. 狼人请睁眼 2. 请选择要击杀的目标 3. 狼人请闭眼"
        
        step.firstActionText = "确认杀害"
        step.firstAction = self.action

        step.secondActionText = "放弃杀害"
        step.secondAction = Step.trueAction

        return step
    }

}

class werewolf_kill_modifier: Modifier {

    override init() {
        super.init()

        self.id = Constants.werewolf_kill_modifier
    }

    override func modify() -> Bool {
        let effect = Effect.factory(id: Constants.werewolf_kill_effect)
        let targets = PlayerMidiator.sharedInstance.selectedPlayers
        if targets.isEmpty {
            return false
        }
        
        self.attachEffect(effect: effect, targets: targets)
        return true
    }

}

extension Constants {
    static let Werewolf = "Werewolf"
    static let werewolf_kill_ability = "werewolf_kill_ability"
    static let werewolf_kill_modifier = "werewolf_kill_modifier"
    static let werewolf_kill_effect = "werewolf_kill_effect"
}
