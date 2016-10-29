//
//  GameManager.swift
//  Willer
//
//  Created by Chuan Ren on 10/28/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import UIKit

class GameManager: NSObject {

    let statusMidiator = StatusMidiator()
    let processMidiator = ProcessMidiator()
    let playerMidiator = PlayerMidiator()

    // MARK: - Singleton
    static let sharedInstance = GameManager()

    override private init() {

    }

    // MARK: -

    func nextDay() {

        // Player
        self.playerMidiator.nextDay()

        // Status
        self.statusMidiator.nextDay()

        // Process
        self.processMidiator.nextDay()
    }

    // MARK: -

    func nextStep() -> Step? {
        return self.processMidiator.nextStep()
    }

}
