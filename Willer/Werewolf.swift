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

        self.abilities = ["WerewolfKillAbility": WerewolfKillAbility()]
    }

}

class WerewolfKillAbility: Ability {

    override init() {
        super.init()

        self.id = "WerewolfKillAbility"

        self.headText = "狼人请睁眼"
        self.bodyText = "请选择要击杀的目标"
        self.firstActionText = "确认杀害"
        self.secondActionText = "放弃杀害"

        self.modifiers = ["WerewolfKillAbility": WerewolfKillModifier()]
    }

}

class WerewolfKillModifier: Modifier {

    override init() {
        super.init()

        self.id = "WerewolfKillModifier"
    }

    override func modify() {
        print(self.id)
    }
    
}
