//
//  GameManager.swift
//  Willer
//
//  Created by Chuan Ren on 10/28/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import UIKit

class GameManager: NSObject {

    // MARK: - Singleton
    static let sharedInstance = GameManager()

    override private init() {

    }

    // MARK: -

    func zeroDay() {
        // Process
        ProcessMidiator.sharedInstance.reload()
    }

    func nextDay() {

        // Player
        PlayerMidiator.sharedInstance.settle()

        // Status
        StatusMidiator.sharedInstance.alternate()

        // Process
        ProcessMidiator.sharedInstance.reload()
    }

    // MARK: -

    func currentStep() -> Step? {
        return ProcessMidiator.sharedInstance.currentStep
    }

    func nextStep() -> Step? {
        return ProcessMidiator.sharedInstance.nextStep()
    }
    
}
