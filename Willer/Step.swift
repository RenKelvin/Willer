//
//  Step.swift
//  Willer
//
//  Created by Chuan Ren on 10/29/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import UIKit

class Step: NSObject {

    var headText: String?
    var bodyText: String?

    var firstActionText: String?
    var secondActionText: String?

    var firstAction: (() -> Bool)?
    var secondAction: (() -> Bool)?

    var ready: (() -> Bool)?

    // MARK: - Helpers

    static func randomStep() -> Step {
        let step = Step()

        step.headText = String(arc4random_uniform(UInt32(10)))
        step.bodyText = String(arc4random_uniform(UInt32(100000000)))

        step.firstActionText = String(arc4random_uniform(UInt32(1000)))
        step.secondActionText = String(arc4random_uniform(UInt32(1000)))

        step.firstAction = trueAction
        step.secondAction = falseAction

        return step
    }

    static func trueAction() -> Bool {
        return true
    }

    static func falseAction() -> Bool {
        return false
    }

}
