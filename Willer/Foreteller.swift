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

}

class foreteller_discover_ability: Ability {

    override init() {
        super.init()

        self.id = Constants.foreteller_discover_ability

        self.cooldown = 1
        self.maxSelected = 0

        self.modifiers = [foreteller_discover_modifier()]
    }

    override func step() -> Step {
        let step = super.step()

        step.headText = "预言家请睁眼"
        step.bodyText = "请选择你要查验的人"

        step.firstActionText = "下一步"
        step.firstAction = self.action

        return step
    }

}

class foreteller_discover_modifier: Modifier {

    override init() {
        super.init()

        self.id = Constants.foreteller_discover_modifier
    }

    override func modify() -> Bool {
        // TODO
        return true
    }
    
}

extension Constants {
    static let Foreteller = "Foreteller"
    static let foreteller_discover_ability = "foreteller_discover_ability"
    static let foreteller_discover_modifier = "foreteller_discover_modifier"
}
