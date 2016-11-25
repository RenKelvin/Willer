//
//  Player.swift
//  Willer
//
//  Created by Chuan Ren on 10/28/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import Foundation

class Player: NSObject {

    var no: Int = 0

    var character: Character

    var effectMachine: EffectMachine = EffectMachine()

    var stateMachine: StateMachine = StateMachine()

    // MARK: -

    override init() {
        self.character = Character()
    }

    init(character: String, no: Int) {
        self.character = Character.factory(character: character)
        self.no = no
    }

    // MARK: -

    func settle() {
        // live -> dying
        if (self.stateMachine.state == .live) {
            let live = self.effectMachine.settle()
            if (!live) {
                self.stateMachine.state = .dying
                self.onDying()
            }
        }
            // dying -> dead
        else if (self.stateMachine.state == .dying) {
            self.stateMachine.state = .dead
        }
    }

    func steps() -> [Step] {
        var steps = [Step]()
        for ability in self.character.abilities {
            steps.append(ability.step())
        }
        return steps
    }

    func dyingSteps() -> [Step] {
        return self.character.dyingSteps()
    }

    func onDying() {
        // Winning check
        if (PlayerMidiator.shared.isWerewolfWiped()) {
            print("好人获胜")
        }
        else if (PlayerMidiator.shared.isTownsfolkWiped() || PlayerMidiator.shared.isPriesthoodWiped()) {
            print("狼人获胜")
        }

        // Dingest steps
        ProcessMidiator.shared.appendSteps(steps: self.character.dyingSteps())
    }
}
