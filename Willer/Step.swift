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

    var preAction: (() -> Void)?
    var posAction: (() -> Void)?

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

    static func enterDayStep() -> Step {
        let step = Step()

        step.headText = "天亮了"
        step.bodyText = "所有人请睁眼"

        func enterDayAction() -> Bool {
            GameManager.sharedInstance.nextDay()
            return true
        }
        step.firstAction = enterDayAction
        step.firstActionText = "进入白天"

        return step
    }

    static func enterNightStep() -> Step {
        let step = Step()

        step.headText = "天黑请闭眼"
        step.bodyText = ""

        func enterNightAction() -> Bool {
            GameManager.sharedInstance.nextDay()
            return true
        }
        step.firstAction = enterNightAction
        step.firstActionText = "进入黑夜"
        
        return step
    }

    static func electSheriffStep() -> Step {
        let step = Step()

        step.headText = "现在开始警长竞选"
        step.bodyText = ""

        step.firstAction = Step.trueAction
        step.firstActionText = "下一步"

        return step
    }

    static func annouceStep() -> Step {
        let step = Step()

        step.headText = "昨夜X号玩家死亡"
        step.bodyText = ""

        step.firstAction = Step.trueAction
        step.firstActionText = "下一步"

        return step
    }

    static func pitchStep() -> Step {
        let step = Step()

        step.headText = "现在开始发言"
        step.bodyText = "从警长左手边X号玩家开始发言"

        step.firstAction = Step.trueAction
        step.firstActionText = "下一步"

        return step
    }

    static func exileStep() -> Step {
        let step = Step()

        step.headText = "现在开始放逐投票"
        step.bodyText = ""

        step.firstAction = Step.trueAction
        step.firstActionText = "下一步"

        return step
    }

}
