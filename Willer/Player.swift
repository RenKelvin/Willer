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

    var selected: Bool = false

    // MARK: -

    override init() {
        self.character = Character()
    }

    init(id: String) {
        self.character = Character(id: id)
    }

    // MARK: -

    func attachEffect(effect: Effect) {
        self.effectSet.insert(effect)
    }

    func steps() -> [Step] {
        var steps = [Step]()
        for (_, ability) in self.character.abilities {
            steps.append(ability.step())
        }
        return steps
    }
    
}
