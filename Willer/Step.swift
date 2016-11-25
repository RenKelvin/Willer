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

    static func simpleStep(head: String, body: String) -> Step {
        let step = Step()

        step.headText = head
        step.bodyText = body

        step.firstActionText = "下一步"
        step.firstAction = trueAction

        return step
    }

    static func enterDayStep() -> Step {
        let step = Step()

        step.headText = "黑夜结束"
        step.bodyText = "天亮了，全体玩家请睁眼"

        func enterDayAction() -> Bool {
            GameManager.shared.nextDay()
            return true
        }
        step.firstAction = enterDayAction
        step.firstActionText = "进入白天"

        return step
    }

    static func enterNightStep() -> Step {
        let step = Step()

        step.headText = "白天结束"
        step.bodyText = "天黑请闭眼"

        func enterNightAction() -> Bool {
            GameManager.shared.nextDay()
            return true
        }
        step.firstAction = enterNightAction
        step.firstActionText = "进入黑夜"

        return step
    }

    static func electSheriffSteps() -> [Step] {
        var steps = [Step]()

        let step1 = Step.simpleStep(head: "警长竞选", body: "现在开始警长竞选，想要竞选警长的玩家请举手")
        steps.append(step1)

        let step2 = Step.simpleStep(head: "警长竞选", body: "从X号玩家开始发言")
        steps.append(step2)

        let step3 = Step.simpleStep(head: "警长竞选", body: "现在开始投票，竞选及退水的玩家不能投票")
        steps.append(step3)

        steps.append(assign_sheriff_ability().step())

        let step5 = Step.simpleStep(head: "警长竞选", body: "X号玩家当选警长")
        steps.append(step5)

        return steps
    }

    static func annouceStep() -> Step {
        let step = Step()

        step.headText = "宣布死者"
        step.bodyText = "昨夜X号玩家死亡"

        step.firstAction = Step.trueAction
        step.firstActionText = "下一步"

        return step
    }

    static func pitchStep() -> Step {
        let step = Step()

        step.headText = "放逐发言"
        step.bodyText = "现在开始发言，从警长左手边X号玩家开始发言"

        step.firstAction = Step.trueAction
        step.firstActionText = "下一步"

        return step
    }

    static func exileStep() -> Step {
        return exile_ability().step()
    }

    static func lastwordsStep(player: Player) -> Step {
        // TODO: can last words?
        let on = true

        var step = Step()
        if (on) {
            step = Step.simpleStep(head: "发表遗言", body: "\(player.no)号玩家请留遗言")
        }
        else {
            step = Step.simpleStep(head: "发表遗言", body: "\(player.no)号玩家没有遗言")
        }
        
        return step
    }
    
}
