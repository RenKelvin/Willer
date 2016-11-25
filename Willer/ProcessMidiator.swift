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

    var firstNightCharacterSequence: [String] = [
    ]
    var firstNightCharacterDictionary: [String: Character] = [:]

    var everyNightCharacterSequence: [String] = [
        Constants.Werewolf,
        Constants.Foreteller,
        Constants.Witch,
        ]
    var everyNightCharacterDictionary: [String: Character] = [:]

    // MARK: - Singleton

    static let shared = ProcessMidiator()

    override private init() {
        super.init()
    }

    func register(player: Player) {
        // Ingest player to character
        player.character.ingest(player: player)

        if self.everyNightCharacterSequence.contains(player.character.id) {
            self.everyNightCharacterDictionary[player.character.id] = player.character
        }

        if self.everyNightCharacterSequence.contains(player.character.id) {
            self.everyNightCharacterDictionary[player.character.id] = player.character
        }
    }

    func reload() {
        // Clear step queue but current one
        //        if !self.stepQueue.isEmpty {
        //            self.stepQueue = [self.stepQueue.first!]
        //        }

        let day = StatusMidiator.shared.currentDay
        if day == 1 {
            // Add firstnight player step
            for characterId in self.firstNightCharacterSequence {
                if let character = self.firstNightCharacterDictionary[characterId] {
                    self.appendSteps(steps: character.steps())
                }
            }
        }

        if day == 2 {
            // Elect sheriff step
            self.appendSteps(steps: Step.electSheriffSteps())
        }

        // Night
        if day % 2 == 1 {
            // Everynight player step
            for characterId in self.everyNightCharacterSequence {
                if let character = self.everyNightCharacterDictionary[characterId] {
                    self.appendSteps(steps: character.steps())
                }
            }

            // Enter night final step
            self.appendStep(step: Step.enterDayStep())
        }
            // Day
        else {
            // Announce
            self.appendStep(step: Step.annouceStep())

            // Pitch
            self.appendStep(step: Step.pitchStep())

            // Exile
            self.appendStep(step: Step.exileStep())

            // Enter day final step
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

    func appendSteps(steps: [Step]) {
        for step in steps {
            self.stepQueue.append(step)
        }
    }
    
    func ingestStep(step: Step) {
        self.stepQueue.insert(step, at: 1)
    }
    
}
