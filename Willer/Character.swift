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

    var abilities: [Ability] = []

    static func factory(character: String) -> Character {
        switch character {

        case Constants.Townsfolk:
            return Townsfolk()

        case Constants.Werewolf:
            return Werewolf()

        case Constants.Foreteller:
            return Foreteller()

        case Constants.Witch:
            return Witch()

        case Constants.Hunter:
            return Hunter()

        default:
            return Character()
        }
    }

    func ingest(player: Player) {
        self.player = player
        for ability in self.abilities {
            ability.ingest(player: player)
        }
    }

    func steps() -> [Step] {
        var steps: [Step] = []

        for ability in self.abilities {
            steps.append(ability.step())
        }

        return steps
    }

    func dyingSteps() -> [Step] {
        let step = Step.lastwordsStep(player: self.player!)
        return [step]
    }

    func isWerewolf() -> Bool {
        return self.id == "Werewolf"
    }

    func isTownsfolk() -> Bool {
        return self.id == "Townsfolk"
    }
    
    func isPriesthood() -> Bool {
        return self.id == "Foreteller" || self.id == "Witch" || self.id == "Hunter"
    }
    
}
