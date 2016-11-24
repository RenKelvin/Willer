//
//  Foreteller.swift
//  Willer
//
//  Created by Chuan Ren on 11/5/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import UIKit

class Foreteller: Character {

    override init() {
        super.init()

        self.id = "Foreteller"
        self.name = "预言家"

        self.abilities = [foreteller_discover_ability()]
    }

    override func steps() -> [Step] {
        var steps = [Step]()

        let firstStep = Step.simpleStep(head: "预言家行动", body: "预言家请睁眼")
        steps.append(firstStep)

        for ability in self.abilities {
            steps.append(ability.step())
        }

        let lastStep = Step.simpleStep(head: "预言家行动", body: "预言家请闭眼")
        steps.append(lastStep)

        return steps
    }

}

class foreteller_discover_ability: Ability {

    override init() {
        super.init()

        self.id = Constants.foreteller_discover_ability

        self.cooldown = 1
        self.maxSelected = 1

        self.modifiers = [foreteller_discover_modifier()]
    }

    override func step() -> Step {
        let step = super.step()

        step.headText = "预言家请睁眼"
        step.bodyText = "请选择你要查验的人"

        step.firstActionText = "确认查验"
        step.firstAction = self.action

        step.secondActionText = "放弃查验"
        step.secondAction = Step.trueAction

        return step
    }

}

class foreteller_discover_modifier: Modifier {

    override init() {
        super.init()

        self.id = Constants.foreteller_discover_modifier
    }

    override func modify() -> Bool {
        let targets = PlayerMidiator.sharedInstance.selectedPlayers
        if targets.isEmpty {
            return false
        }

        let player = targets.first!
        var role = ""
        if (player.character.isWerewolf()) {
            role = "狼人"
        }
        else {
            role = "好人"
        }
        let step = Step.simpleStep(head: "预言家行动", body: "他的身份是 "+role)
        ProcessMidiator.sharedInstance.ingestStep(step: step)

        return true
    }
    
}

extension Constants {
    static let Foreteller = "Foreteller"
    static let foreteller_discover_ability = "foreteller_discover_ability"
    static let foreteller_discover_modifier = "foreteller_discover_modifier"
}
