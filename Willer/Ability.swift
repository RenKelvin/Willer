//
//  Ability.swift
//  Willer
//
//  Created by Chuan Ren on 10/28/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import UIKit

class Ability: NSObject {

    var id: String = "Ability:id"

    var passive: Bool?
    //    var trigger: AbilityTrigger = .none

    var headText: String = "Ability:headText"
    var bodyText: String = "Ability:bodyText"
    var firstActionText: String = "Ability:firstActionText"
    var secondActionText: String = "Ability:secondActionText"

    var maxSelected: Int = 0

    var modifiers: [String: Modifier] = [:]

    func perform() {
        for (_, modifier) in modifiers {
            modifier.modify()
        }
    }

    func ready() -> Bool {
        PlayerMidiator.sharedInstance.maxSelected = self.maxSelected

        return true
    }

    func action() -> Bool {
        self.perform()

        return true
    }

    func step() -> Step {
        let step = Step()

        step.headText = self.headText
        step.bodyText = self.bodyText

        step.firstActionText = firstActionText
        step.firstAction = self.action

        step.secondActionText = secondActionText
        step.secondAction = Step.falseAction

        step.ready = self.ready

        return step
    }

}
//
//enum AbilityTrigger: String {
//    case none = ""
//    case godCalled = "GodCalled"
//    case playerCast = "PlayerCast"
//    case playerDead = "PlayerDead"
//}
