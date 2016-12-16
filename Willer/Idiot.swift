//
//  Idiot.swift
//  Willer
//
//  Created by Chuan Ren on 12/15/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import UIKit

class Idiot: Character {

    override init() {
        super.init()

        self.id = "Idiot"
        self.name = "白痴"

        self.abilities = [idiot_reveal_ability()]
    }

    override func onDying() {
        let idiotRevealEffect = Effect.factory(id: Constants.idiot_reveal_effect)
        let exileEffect = Effect.factory(id: Constants.exile_effect)

        // Revealed -> Dead
        if !self.player!.effectMachine.effects.contains(idiotRevealEffect) && self.player!.effectMachine.effects.contains(exileEffect) {
            self.player!.effectMachine.attachEffect(effect: idiotRevealEffect)
            ProcessMidiator.shared.appendSteps(steps: self.steps())
        }
            // Not revealed -> Live
        else {
            ProcessMidiator.shared.appendSteps(steps: self.dyingSteps())
        }
    }

}

class idiot_reveal_ability: Ability {

    override init() {
        super.init()

        self.id = Constants.idiot_reveal_ability

        self.maxSelected = 0

        self.modifiers = [idiot_reveal_modifier()]
    }

    override func step() -> Step {
        let step = Step.simpleStep(head: "白痴死亡", body: "可以发动技能，免于死亡")

        step.firstActionText = "下一步"
        step.firstAction = self.action

        return step
    }

}

class idiot_reveal_modifier: Modifier {

    override init() {
        super.init()
        self.id = Constants.idiot_reveal_modifier
    }

    override func modify() -> Bool {
        self.player!.stateMachine.state = .live
        return true
    }

}

extension Constants {
    static let Idiot = "Idiot"

    static let idiot_reveal_ability = "idiot_reveal_ability"
    static let idiot_reveal_modifier = "idiot_reveal_modifier"
    static let idiot_reveal_effect = "idiot_reveal_effect"
}
