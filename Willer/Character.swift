//
//  Character.swift
//  Willer
//
//  Created by Chuan Ren on 10/28/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import SwiftyJSON

class Character: NSObject {

    var id: String?
    var name: String = ""

    var abilities: [String: Ability] = [:]

    override init() {
        let ability = Ability()
        self.abilities["123"] = ability
    }

    init(id: String) {
        // Meta
        let json = JSON(file: id)

        self.id = json["id"].string
        self.name = json["name"].stringValue

        // Ability
        for (abilityId, abilityJson) in json["abilities"].dictionaryValue {
            let ability = Ability(json: abilityJson)
            self.abilities[abilityId] = ability
        }
    }
    
}
