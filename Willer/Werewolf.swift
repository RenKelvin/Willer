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

        self.abilities = [werewolf_kill_ability(), werewolf_suicide_ability()]
    }

    override func steps() -> [Step] {
        var steps = [Step]()

        let firstStep = Step.simpleStep(head: "狼人行动", body: "狼人请睁眼")
        steps.append(firstStep)

        steps.append(self.abilities[0].step())

        let lastStep = Step.simpleStep(head: "狼人行动", body: "狼人请闭眼")
        steps.append(lastStep)

        return steps
    }

    override func onDying() {
        if self.player!.effectMachine.effects.contains(Effect.factory(id: Constants.werewolf_suicide_effect)) {
            ProcessMidiator.shared.cutSteps(steps: self.dyingSteps())
        }
        else {
            ProcessMidiator.shared.appendSteps(steps: self.dyingSteps())
        }
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

        step.headText = "狼人行动"
        step.bodyText = "请选择要击杀的目标"

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
        let targets = PlayerMidiator.shared.selectedPlayers
        if targets.isEmpty {
            return false
        }

        self.attachEffect(effect: effect, targets: targets)
        return true
    }

}

// MARK: - Kill

class werewolf_suicide_ability: Ability {

    override init() {
        super.init()

        self.id = Constants.werewolf_suicide_ability

        self.cooldown = -9999

        self.modifiers = [werewolf_suicide_modifier()]
    }

}

class werewolf_suicide_modifier: Modifier {

    override init() {
        super.init()

        self.id = Constants.werewolf_suicide_modifier
    }

    override func modify() -> Bool {
        let effect = Effect.factory(id: Constants.werewolf_suicide_effect)
        self.takeEffect(effect: effect, targets: [self.player!])
        return true
    }

}

extension Constants {
    static let Werewolf = "Werewolf"

    static let werewolf_kill_ability = "werewolf_kill_ability"
    static let werewolf_kill_modifier = "werewolf_kill_modifier"
    static let werewolf_kill_effect = "werewolf_kill_effect"
    
    static let werewolf_suicide_ability = "werewolf_suicide_ability"
    static let werewolf_suicide_modifier = "werewolf_suicide_modifier"
    static let werewolf_suicide_effect = "werewolf_suicide_effect"
}
