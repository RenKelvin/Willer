//
//  Player.swift
//  Willer
//
//  Created by Chuan Ren on 10/28/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import GameplayKit

class Player: GKEntity {

    var character: Character?

    var effectSet: Set<Effect> = []

    func attachEffect(effect: Effect) {
        self.effectSet.insert(effect)
    }

}
