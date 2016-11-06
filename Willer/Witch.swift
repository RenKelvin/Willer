//
//  Witch.swift
//  Willer
//
//  Created by Chuan Ren on 11/4/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import UIKit

class Witch: Character {

    override init() {
        super.init()

        self.id = "Witch"
        self.name = "女巫"

        self.abilities = [witch_save_ability(), witch_poison_ability()]
    }

}

// MARK: - Save

class witch_save_ability: Ability {

    var _step: Step = Step()

    override init() {
        super.init()

        self.id = Constants.witch_save_ability

        self.maxSelected = 0

        self.modifiers = [witch_save_modifier()]
    }

    override func step() -> Step {
        _step = super.step()

        return _step
    }

    override func preAction() {

        _step.headText = "女巫行动"

        let player = PlayerMidiator.sharedInstance.werewolfKilledPlayers().first
        if player != nil && self.avalaible() {
            _step.bodyText = "女巫请睁眼 今晚这位玩家(\(player!.no)号)死亡，请问你要救吗"
        }
        else {
            _step.bodyText = "女巫请睁眼 今晚这位玩家死亡，请问你要救吗"
        }

        if self.avalaible() {
            _step.firstActionText = "救"
            _step.firstAction = self.action

            _step.secondActionText = "不救"
            _step.secondAction = Step.trueAction
        }
        else {
            _step.firstActionText = "解药已使用"
            _step.firstAction = Step.falseAction

            _step.secondActionText = "下一步"
            _step.secondAction = Step.trueAction
        }
    }

}

class witch_save_modifier: Modifier {

    override init() {
        super.init()

        self.id = Constants.witch_save_modifier
    }

    override func modify() -> Bool {
        let effect = Effect.factory(id: Constants.witch_save_effect)
        let targets = PlayerMidiator.sharedInstance.werewolfKilledPlayers()

        self.attachEffect(effect: effect, targets: targets)
        return true
    }

}

// MARK: - Poison

class witch_poison_ability: Ability {

    override init() {
        super.init()

        self.id = Constants.witch_poison_ability

        self.maxSelected = 1

        self.modifiers = [witch_poison_modifier()]
    }

    override func step() -> Step {
        let step = super.step()

        step.headText = "女巫行动"
        step.bodyText = "请问你要毒死谁吗"

        if self.avalaible() {
            step.firstActionText = "毒杀"
            step.firstAction = self.action

            step.secondActionText = "不毒"
            step.secondAction = Step.trueAction
        }
        else {
            step.firstActionText = "毒药已使用"
            step.firstAction = Step.falseAction

            step.secondActionText = "下一步"
            step.secondAction = Step.trueAction

        }

        return step
    }

}

class witch_poison_modifier: Modifier {

    override init() {
        super.init()

        self.id = Constants.witch_poison_modifier
    }

    override func modify() -> Bool {
        let effect = Effect.factory(id: Constants.witch_poison_effect)
        let targets = PlayerMidiator.sharedInstance.selectedPlayers
        if targets.isEmpty {
            return false
        }

        self.attachEffect(effect: effect, targets: targets)
        return true
    }

}

extension Constants {
    static let Witch = "Witch"

    static let witch_save_ability = "witch_save_ability"
    static let witch_save_modifier = "witch_save_modifier"
    static let witch_save_effect = "witch_save_effect"
    
    static let witch_poison_ability = "witch_poison_ability"
    static let witch_poison_modifier = "witch_poison_modifier"
    static let witch_poison_effect = "witch_poison_effect"
}
