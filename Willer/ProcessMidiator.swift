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
        // Clear step queue but current one
        if !self.stepQueue.isEmpty {
            self.stepQueue = [self.stepQueue.first!]
        }

        let day = StatusMidiator.sharedInstance.currentDay
        if day == 1 {
            // Add firstnight player step
            for abilityName in self.firstNightAbilitySequence {
                if let ability = self.firstNightAbilityDictionary[abilityName] {
                    self.appendStep(step: ability.step())
                }
            }
        }

        if day == 2 {
            // Elect sheriff step
            self.appendStep(step: Step.electSheriffStep())
        }

        if day % 2 == 1 {
            // Add everynight player step
            for abilityName in self.everyNightAbilitySequence {
                if let ability = self.everyNightAbilityDictionary[abilityName] {
                    self.appendStep(step: ability.step())
                }
            }

            // Add enter night final step
            self.appendStep(step: Step.enterDayStep())
        }
        else {
            // Announce
            self.appendStep(step: Step.annouceStep())

            // Pitch
            self.appendStep(step: Step.pitchStep())

            // Exile
            self.appendStep(step: Step.exileStep())

            // Add enter day final step
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
