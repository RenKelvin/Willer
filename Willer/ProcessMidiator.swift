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

    var firstNightAbilitySequence: [String] = [
    ]
    var firstNightAbilityDictionary: [String: Ability] = [:]

    var everyNightAbilitySequence: [String] = [
        Constants.werewolf_kill_ability,
        Constants.foreteller_discover_ability,
        Constants.witch_save_ability,
        Constants.witch_poison_ability,
        ]
    var everyNightAbilityDictionary: [String: Ability] = [:]

    // MARK: - Singleton

    static let sharedInstance = ProcessMidiator()

    override private init() {
        super.init()
    }

    func register(player: Player) {
        player.character.ingest(player: player)

        for ability in player.character.abilities {
            let abilityId = ability.id

            if self.firstNightAbilitySequence.contains(abilityId) {
                self.firstNightAbilityDictionary[abilityId] = ability
            }

            if self.everyNightAbilitySequence.contains(abilityId) {
                self.everyNightAbilityDictionary[abilityId] = ability
            }
        }
    }

    func reload() {
        let day = StatusMidiator.sharedInstance.currentDay

        // Clear step queue but current one
        if !self.stepQueue.isEmpty {
            self.stepQueue = [self.stepQueue.first!]
        }

        // Add firstnight player step
        if day == 1 {
            for abilityName in self.firstNightAbilitySequence {
                if let ability = self.firstNightAbilityDictionary[abilityName] {
                    self.appendStep(step: ability.step())
                }
            }
        }

        // Add everynight player step
        if day > 0 {
            for abilityName in self.everyNightAbilitySequence {
                if let ability = self.everyNightAbilityDictionary[abilityName] {
                    self.appendStep(step: ability.step())
                }
            }
        }

        // Add enter night or day final step
        if day > 0 {
            if StatusMidiator.sharedInstance.isNight {
                self.appendStep(step: Step.enterDayStep())
            }
            else {
                self.appendStep(step: Step.enterNightStep())
            }
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
