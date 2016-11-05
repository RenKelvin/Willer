//
//  Ability.swift
//  Willer
//
//  Created by Chuan Ren on 10/28/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import SwiftyJSON

class Ability: NSObject {

    var id: String?

    var passive = true
    var trigger: AbilityTrigger = .none

    var headText = ""
    var bodyText = ""
    var firstActionText = "FirstAction"
    var secondActionText: String?

    var maxSelected: Int = 0

    var modifiers: [String: Modifier] = [:]

    override init() {

    }

    init(json: JSON) {
        self.id = json["id"].stringValue

        self.passive = json["passive"].boolValue
        self.trigger = AbilityTrigger(rawValue: json["trigger"].stringValue)!

        self.headText = json["headText"].stringValue
        self.bodyText = json["bodyText"].stringValue
        self.firstActionText = json["firstActionText"].stringValue
        self.secondActionText = json["secondActionText"].string

        self.maxSelected = json["maxSelected"].intValue

        for (modifierId, modifierJson) in json["modifiers"].dictionaryValue {
            let modifier = Modifier.factory(json: modifierJson)
            self.modifiers[modifierId] = modifier
        }
    }

    func perform() {
        for (_, modifier) in self.modifiers {
            modifier.perform()
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

enum AbilityTrigger: String {
    case none = ""
    case godCalled = "GodCalled"
    case playerCast = "PlayerCast"
    case playerDead = "PlayerDead"
}
