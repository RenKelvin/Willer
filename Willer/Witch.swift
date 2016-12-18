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

    override func steps() -> [Step] {
        var steps = [Step]()

        let firstStep = Step.simpleStep(head: "女巫行动", body: "女巫请睁眼")
        steps.append(firstStep)

        for ability in self.abilities {
            steps.append(ability.step())
        }

        let lastStep = Step.simpleStep(head: "女巫行动", body: "女巫请闭眼")
        steps.append(lastStep)

        return steps
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

        super.preAction()

        _step.headText = "女巫行动"

        let player = PlayerMidiator.shared.werewolfKilledPlayers().first
        if player != nil && self.avalaible() {
            _step.bodyText = "今晚这位玩家(\(player!.no)号)死亡，请问你要救吗"
        }
        else {
            _step.bodyText = "今晚这位玩家死亡，请问你要救吗"
        }

        if !self.player!.stateMachine.living {
            _step.firstActionText = "女巫已死亡"
            _step.firstAction = Step.falseAction

            _step.secondActionText = "下一步"
            _step.secondAction = Step.trueAction
        }
        else {
            if !self.avalaible() {
                _step.firstActionText = "解药已使用"
                _step.firstAction = Step.falseAction

                _step.secondActionText = "下一步"
                _step.secondAction = Step.trueAction
            }
            else if player != nil && player!.no == self.player!.no && StatusMidiator.shared.currentDay != 1 {
                _step.firstActionText = "无法自救"
                _step.firstAction = Step.falseAction

                _step.secondActionText = "下一步"
                _step.secondAction = Step.trueAction
            }
            else {
                _step.firstActionText = "救"
                _step.firstAction = self.action

                _step.secondActionText = "不救"
                _step.secondAction = Step.trueAction
            }
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
        let targets = PlayerMidiator.shared.werewolfKilledPlayers()
        self.attachEffect(effect: effect, targets: targets)

        self.attachEffect(effect: Effect.factory(id: "witch_save_use_effect"), targets: [self.player!])

        return true
    }

}

// MARK: - Poison

class witch_poison_ability: Ability {

    var _step: Step = Step()

    override init() {
        super.init()

        self.id = Constants.witch_poison_ability

        self.maxSelected = 1

        self.modifiers = [witch_poison_modifier()]
    }

    override func step() -> Step {
        _step = super.step()

        return _step
    }

    override func preAction() {

        super.preAction()

        _step.headText = "女巫行动"
        _step.bodyText = "请问你要毒死谁吗"

        if !self.player!.stateMachine.living {
            _step.firstActionText = "女巫已死亡"
            _step.firstAction = Step.falseAction

            _step.secondActionText = "下一步"
            _step.secondAction = Step.trueAction
        }
        else {
            if !self.avalaible() {
                _step.firstActionText = "毒药已使用"
                _step.firstAction = Step.falseAction

                _step.secondActionText = "下一步"
                _step.secondAction = Step.trueAction
            }
            else if self.player!.effectMachine.effects.contains(Effect.factory(id: "witch_save_use_effect")) {
                _step.firstActionText = "已用过解药"
                _step.firstAction = Step.falseAction

                _step.secondActionText = "下一步"
                _step.secondAction = Step.trueAction
            }
            else {
                _step.firstActionText = "毒杀"
                _step.firstAction = self.action

                _step.secondActionText = "不毒"
                _step.secondAction = Step.trueAction
            }
        }
    }

}

class witch_poison_modifier: Modifier {

    override init() {
        super.init()

        self.id = Constants.witch_poison_modifier
    }

    override func modify() -> Bool {
        let effect = Effect.factory(id: Constants.witch_poison_effect)
        let targets = PlayerMidiator.shared.selectedPlayers
        if targets.isEmpty {
            return false
        }

        self.attachEffect(effect: effect, targets: targets)
        return true
    }

}

// MARK: -

extension Constants {
    static let Witch = "Witch"

    static let witch_save_ability = "witch_save_ability"
    static let witch_save_modifier = "witch_save_modifier"
    static let witch_save_effect = "witch_save_effect"
    static let witch_save_use_effect = "witch_save_use_effect"
    
    static let witch_poison_ability = "witch_poison_ability"
    static let witch_poison_modifier = "witch_poison_modifier"
    static let witch_poison_effect = "witch_poison_effect"
}
