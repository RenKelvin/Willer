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

    var passive: Bool = false

    var modifiers: [String: Modifier] = [:]

    override init() {

    }

    init(json: JSON) {
        self.passive = json["passive"].boolValue

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
        self.perform()
        return true
    }
    
}
