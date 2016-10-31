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

    // MARK: - Update game view controller

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

    func nextStep() {
        //
        ProcessMidiator.sharedInstance.nextStep()

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

    func firstAction() {
        let result = ProcessMidiator.sharedInstance.currentStep?.firstAction?()
        if result != nil && result! {
            self.nextStep()
        }
    }

    func secondAction() {
        let result = ProcessMidiator.sharedInstance.currentStep?.secondAction?()
        if result != nil && result! {
            self.nextStep()
        }
    }

}
