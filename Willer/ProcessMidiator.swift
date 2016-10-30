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
        // Clear current queue
        self.stepQueue.removeAll()

        //

        // Add enter night or day step
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
    func nextStep() -> Step? {

        self.stepQueue = Array(self.stepQueue.dropFirst())

        return self.currentStep
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

        return step
    }

    func enterNightStep() -> Step {
        let step = Step()

        step.headText = "天黑请闭眼"

        return step
    }

}
