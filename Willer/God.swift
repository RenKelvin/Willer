//
//  God.swift
//  Willer
//
//  Created by Chuan Ren on 11/6/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import UIKit

class God: Character {

}

// Assign sheriff

class assign_sheriff_ability: Ability {

    override init() {
        super.init()

        self.id = Constants.assign_sheriff_ability

        self.cooldown = 1

        self.maxSelected = 1

        self.modifiers = [assign_sheriff_modifier()]
    }

    override func step() -> Step {
        let step = super.step()

        step.headText = "警长竞选"
        step.bodyText = "（）"

        step.firstActionText = "确认警长"
        step.firstAction = self.action

        step.secondActionText = "没有警长"
        step.secondAction = Step.trueAction

        return step
    }

}

class assign_sheriff_modifier: Modifier {

    override init() {
        super.init()

        self.id = Constants.assign_sheriff_modifier
    }

    override func modify() -> Bool {
        let effect = Effect.factory(id: Constants.sheriff_effect)
        let targets = PlayerMidiator.shared.selectedPlayers
        if targets.isEmpty {
            return false
        }

        self.attachEffect(effect: effect, targets: targets)
        return true
    }
    
}

// Exile
class exile_ability: Ability {

    override init() {
        super.init()

        self.id = Constants.exile_ability

        self.cooldown = 1

        self.maxSelected = 1

        self.modifiers = [exile_modifier()]
    }

    override func step() -> Step {
        let step = super.step()

        step.headText = "放逐投票"
        step.bodyText = "现在开始放逐投票，各位玩家请投票 （）"

        step.firstActionText = "确认放逐"
        step.firstAction = self.action

        step.secondActionText = "放弃放逐"
        step.secondAction = Step.trueAction
        
        return step
    }
    
}

class exile_modifier: Modifier {

    override init() {
        super.init()

        self.id = Constants.exile_modifier
    }

    override func modify() -> Bool {
        let effect = Effect.factory(id: Constants.exile_effect)
        let targets = PlayerMidiator.shared.selectedPlayers
        if targets.isEmpty {
            return false
        }

        self.takeEffect(effect: effect, targets: targets)
        return true
    }
    
}
