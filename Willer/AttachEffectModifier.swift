//
//  AttachEffectModifier.swift
//  Willer
//
//  Created by Chuan Ren on 10/29/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import SwiftyJSON

enum ModifierTargetType {
    case target
    case caster
    case game
}

class AttachEffectModifier: Modifier {

    var targetType: ModifierTargetType = .target
    var targetAmount: Int = 0

    var effect: Effect?

    override init() {
        super.init()
    }

    override init(json: JSON) {
        super.init(json: json)

        for (_, effectJson) in json["effects"].dictionary! {
            self.effect = Effect(json: effectJson)
        }
    }

    override func perform() {
        switch self.targetType {
        case .target:
            let target = PlayerMidiator.sharedInstance.selectedPlayers.first
            target?.attachEffect(effect: self.effect!)

        default:
            break
        }
    }
    
}
