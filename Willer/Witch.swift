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

        self.abilities = [Constants.witch_save_ability: witch_save_ability()]
    }

}

class witch_save_ability: Ability {

    override init() {
        super.init()

        self.id = Constants.witch_save_ability

        self.headText = "女巫请睁眼"
        self.bodyText = "X号玩家死亡，请问你要救吗"
        self.firstActionText = "救"
        self.secondActionText = "不救"

        self.maxSelected = 0

        self.modifiers = [Constants.witch_save_modifier: witch_save_modifier()]
    }

}

class witch_save_modifier: Modifier {

    override init() {
        super.init()

        self.id = Constants.witch_save_modifier
    }

    override func modify() {
        let effect = Effect(id: Constants.witch_save_effect)
        let targets = PlayerMidiator.sharedInstance.werewolfKilledPlayers()
        self.attachEffect(effect: effect, targets: targets)
    }

}

extension Constants {
    static let witch_save_ability = "witch_save_ability"
    static let witch_save_modifier = "witch_save_modifier"
    static let witch_save_effect = "witch_save_effect"
}
