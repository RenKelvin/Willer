//
//  Hunter.swift
//  Willer
//
//  Created by Chuan Ren on 11/5/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import UIKit

class Hunter: Character {

    override init() {
        super.init()

        self.id = "Hunter"
        self.name = "猎人"

        self.abilities = [hunter_shot_ability()]
    }

    override func onDying() {
        for ability in self.abilities {
            let step = ability.step()
            ProcessMidiator.shared.ingestStep(step: step)
        }
    }

}

class hunter_shot_ability: Ability {

    override init() {
        super.init()

        self.id = Constants.hunter_shot_ability

        self.maxSelected = 1

        self.modifiers = [hunter_shot_modifier()]
    }

    override func step() -> Step {
        let step = super.step()

        step.headText = "猎人请发动技能"
        step.bodyText = "请选择你要带走的玩家"

        step.firstActionText = "确定枪杀"
        step.firstAction = self.action

        step.secondActionText = "放弃枪杀"
        step.secondAction = Step.trueAction

        return step
    }

}

class hunter_shot_modifier: Modifier {

    override init() {
        super.init()

        self.id = Constants.hunter_shot_modifier
    }

    override func modify() -> Bool {
        let effect = Effect.factory(id: Constants.hunter_shot_effect)
        let targets = PlayerMidiator.shared.selectedPlayers
        if targets.isEmpty {
            return false
        }

        self.takeEffect(effect: effect, targets: targets)
        return true
    }
    
}

extension Constants {
    static let Hunter = "Hunter"

    static let hunter_shot_ability = "hunter_shot_ability"
    static let hunter_shot_modifier = "hunter_shot_modifier"
    static let hunter_shot_effect = "hunter_shot_effect"
}
