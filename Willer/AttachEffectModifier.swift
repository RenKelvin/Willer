//
//  AttachEffectModifier.swift
//  Willer
//
//  Created by Chuan Ren on 10/29/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import UIKit

enum ModifierTargetType {
    case target
    case caster
    case game
}

class AttachEffectModifier: Modifier {

    var targetType: ModifierTargetType = .target

    var targetAmount: Int = 0

    var effect: Effect?

    override func perform() {
        switch self.targetType {
        case .target:
            // TODO: Get targets from GameManager
            let target = Player()
            target.attachEffect(effect: self.effect!)
        default:
            break
        }
    }

}
