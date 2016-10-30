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

    // MARK: - Singleton

    static let sharedInstance = ProcessMidiator()

    override private init() {
        
    }

    func reload() {
        // Clear current step queue
        self.stepQueue.removeAll()

        // Add character step

        // Add enter night or day final step
        if StatusMidiator.sharedInstance.isNight {
            self.appendStep(step: self.enterDayStep())
        }
        else {
            self.appendStep(step: self.enterNightStep())
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

    func enterDayStep() -> Step {
        let step = Step()

        step.headText = "天亮了"

        func enterDayAction() -> Bool {
            GameManager.sharedInstance.nextDay()
            return true
        }
        step.firstAction = enterDayAction
        step.firstActionText = "黑夜结束"

        return step
    }

    func enterNightStep() -> Step {
        let step = Step()

        step.headText = "天黑请闭眼"

        func enterNightAction() -> Bool {
            GameManager.sharedInstance.nextDay()
            return true
        }
        step.firstAction = enterNightAction
        step.firstActionText = "进入黑夜"

        return step
    }

}
