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

        if self.firstNightCharacterSequence.contains(player.character.id) {
            self.firstNightCharacterDictionary[player.character.id] = player.character
        }

        if self.everyNightCharacterSequence.contains(player.character.id) {
            self.everyNightCharacterDictionary[player.character.id] = player.character
        }
    }

    func reload() {
        let day = StatusMidiator.shared.currentDay

        if day == 0 {
            self.appendStep(step: Step.startStep())
            return
        }

        if day == 1 {
            // Add firstnight player step
            for characterId in self.firstNightCharacterSequence {
                if let character = self.firstNightCharacterDictionary[characterId] {
                    self.appendSteps(steps: character.steps())
                }
            }
        }

        // Night
        if day % 2 == 1 {
            // Everynight player step
            for characterId in self.everyNightCharacterSequence {
                if let character = self.everyNightCharacterDictionary[characterId] {
                    self.appendSteps(steps: character.steps())
                }
            }
        }
            // Day
        else {
            // Announce
            self.ingestStep(step: Step.annouceStep())

            // Pitch
            // self.appendStep(step: Step.pitchStep())

            // Exile
            self.appendStep(step: Step.exileStep())
        }

        if (GameManager.shared.deck?.sheriff)! && day == 2 {
            // Elect sheriff step
            self.ingestSteps(steps: Step.electSheriffSteps())
        }
    }

    /// Drop the current step and move to next one in the step queue
    ///
    /// - Returns: The current step
    func nextStep() {
        self.stepQueue = Array(self.stepQueue.dropFirst())

        //
        if (self.stepQueue.isEmpty) {
            let day = StatusMidiator.shared.currentDay
            if day % 2 == 1 {
                // Enter day final step
                self.appendStep(step: Step.enterDayStep())
            }
            else {
                // Enter night final step
                self.appendStep(step: Step.enterNightStep())
            }
        }
    }

    func appendStep(step: Step) {
        self.stepQueue.append(step)
    }

    func appendSteps(steps: [Step]) {
        self.stepQueue.append(contentsOf: steps)
    }

    func ingestStep(step: Step) {
        self.stepQueue.insert(step, at: 1)
    }
    
    func ingestSteps(steps: [Step]) {
        self.stepQueue.insert(contentsOf: steps, at: 1)
    }

    func cutSteps(steps: [Step]) {
        self.stepQueue.insert(contentsOf: steps, at: 0)
        GameManager.shared.updateViewController()
    }

}
