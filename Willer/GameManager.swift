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

    func updateViewController() {
        NotificationCenter.default.post(name: NSNotification.Name("OnUpdate"), object: nil)
    }

    // MARK: -

    func zeroDay() {
        // Process
        ProcessMidiator.sharedInstance.reload()

        //
        self.updateViewController()
}

    func nextDay() {

        // Player
        PlayerMidiator.sharedInstance.settle()

        // Status
        StatusMidiator.sharedInstance.alternate()

        // Process
        ProcessMidiator.sharedInstance.reload()

        //
        self.updateViewController()
    }

    // MARK: -

    func currentDay() -> Int {
        return StatusMidiator.sharedInstance.currentDay
    }

    func currentStep() -> Step? {
        return ProcessMidiator.sharedInstance.currentStep
    }

    func nextStep() {
        return ProcessMidiator.sharedInstance.nextStep()
    }
    
}
