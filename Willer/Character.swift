//
//  Character.swift
//  Willer
//
//  Created by Chuan Ren on 10/28/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import UIKit

class Character: NSObject {

    weak var player: Player?

    var id: String = "Character:id"
    var name: String = "Character:name"

    var abilities: [String: Ability] = [:]

    static func factory(character: String) -> Character {
        switch character {
        case Constants.Townsfolk:
            return Townsfolk()
        case Constants.Werewolf:
            return Werewolf()
        case Constants.Witch:
            return Witch()
        default:
            return Character()
        }
    }

    func ingest(player: Player) {
        self.player = player
        for (_, ability) in self.abilities {
            ability.ingest(player: player)
        }
    }
    
}
