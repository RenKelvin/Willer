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

    var headText = ""
    var bodyText = ""
    var firstActionText = "FirstAction"
    var secondActionText: String?

    var modifiers: [String: Modifier] = [:]

    override init() {

    }

    init(json: JSON) {
        self.id = json["id"].stringValue

        self.passive = json["passive"].boolValue

        self.headText = json["headText"].stringValue
        self.bodyText = json["bodyText"].stringValue
        self.firstActionText = json["firstActionText"].stringValue
        self.secondActionText = json["secondActionText"].string

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

    func action() -> Bool {
        // self.perform()

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
        
        return step
    }
    
}
