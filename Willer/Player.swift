//
//  Player.swift
//  Willer
//
//  Created by Chuan Ren on 10/28/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import Foundation

class Player: NSObject {

    var no: Int = 0

    var character: Character

    var effectSet: Set<Effect> = []

    var alive: Bool = true

    // MARK: -

    override init() {
        self.character = Character()
    }

    // MARK: -

    func attachEffect(effect: Effect) {
        self.effectSet.insert(effect)
    }

    func steps() -> [Step] {
        var steps = [Step]()
        for ability in self.character.abilities {
            steps.append(self.abilityStep(ability: ability))
        }
        return steps
    }

    func abilityStep(ability: Ability) -> Step {
        var step = Step()
        step.headText = "女巫请睁眼"
        step.bodyText = "5号玩家死亡，请问你要救吗？"

        step.firstActionText = "救人"
        step.firstAction = ability.action

        func emptyAction() -> Bool {
            return false
        }

        step.secondActionText = "不救"
        step.secondAction = emptyAction
        
        return step
    }
    
}
