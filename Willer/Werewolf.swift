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

        self.abilities = ["werewolf_kill_ability": werewolf_kill_ability()]
    }

}

class werewolf_kill_ability: Ability {

    override init() {
        super.init()

        self.id = "werewolf_kill_ability"

        self.headText = "狼人请睁眼"
        self.bodyText = "请选择要击杀的目标"
        self.firstActionText = "确认杀害"
        self.secondActionText = "放弃杀害"

        self.maxSelected = 1

        self.modifiers = ["werewolf_kill_modifier": werewolf_kill_modifier()]
    }

}

class werewolf_kill_modifier: Modifier {

    override init() {
        super.init()

        self.id = "werewolf_kill_modifier"
    }

    override func modify() {
        let effect = Effect(id: "werewolf_kill_effect")
        let targets = PlayerMidiator.sharedInstance.selectedPlayers
        self.attachEffect(effect: effect, targets: targets)
    }
    
}
