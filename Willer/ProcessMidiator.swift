//
//  ProcessMidiator.swift
//  Willer
//
//  Created by Chuan Ren on 10/29/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import UIKit

class ProcessMidiator: NSObject {

    var stepQueue: [Step] = []
    var currentStep: Step? {
        return self.stepQueue.first
    }

    var firstNightAbilitySequence: [String: Ability?] = [:]

    var everyNightAbilitySequence: [String: Ability?] = [
        Constants.werewolf_kill_ability: nil,
        Constants.foreteller_discover_ability: nil,
        Constants.witch_save_ability: nil,
        ]

    // MARK: - Singleton

    static let sharedInstance = ProcessMidiator()

    override private init() {
        super.init()
    }

    func register(player: Player) {
        player.character.ingest(player: player)

        for (abilityName, ability) in player.character.abilities {
            if let _ = self.firstNightAbilitySequence[abilityName] {
                self.firstNightAbilitySequence[abilityName] = ability
            }
            if let _ = self.everyNightAbilitySequence[abilityName] {
                self.everyNightAbilitySequence[abilityName] = ability
            }
        }
    }

    func reload() {
        // Clear step queue but current one
        if !self.stepQueue.isEmpty {
            self.stepQueue = [self.stepQueue.first!]
        }

        // Add firstnight player step


        // Add everynight player step
        for (_, ability) in self.everyNightAbilitySequence {
            if let ability = ability {
                self.appendStep(step: ability.step())
            }
        }

        // Add enter night or day final step
        if StatusMidiator.sharedInstance.isNight {
            self.appendStep(step: Step.enterDayStep())
        }
        else {
            self.appendStep(step: Step.enterNightStep())
        }
    }

    /// Drop the current step and move to next one in the step queue
    ///
    /// - Returns: The current step
    func nextStep() {
        self.stepQueue = Array(self.stepQueue.dropFirst())
    }

    func appendStep(step: Step) {
        self.stepQueue.append(step)
    }

    func insertAfterCurrentStep(step: Step) {
        self.stepQueue.insert(step, at: 1)
    }
    
}
