//
//  Character.swift
//  Willer
//
//  Created by Chuan Ren on 10/28/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import GameplayKit

class Character: NSObject {

    var id: String?

    var abilities: [Ability] = []

    override init() {
        let ability = Ability()
        self.abilities.append(ability)
    }

}
