//
//  EffectMachine.swift
//  Willer
//
//  Created by Chuan Ren on 11/4/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import GameplayKit

class EffectMachine: NSObject {

    var effects: Set<Effect> = []

    var ruleSystem = GKRuleSystem()

    override init() {
        super.init()

        self.fillRules()
    }

    func fillRules() {
        let rule1 = GKRule(blockPredicate: { (system: GKRuleSystem) -> Bool in
            let effect = Effect(id: Constants.werewolf_kill_effect)
            if self.effects.contains(effect) { return true }
            else { return false }
        }) { (system: GKRuleSystem) -> Void in
            system.retractFact("alive" as NSObjectProtocol)
        }
        self.ruleSystem.add(rule1)

        let rule2 = GKRule(blockPredicate: { (system: GKRuleSystem) -> Bool in
            let effect = Effect(id: Constants.witch_save_effect)
            if self.effects.contains(effect) { return true }
            else { return false }
        }) { (system: GKRuleSystem) -> Void in
            system.assertFact("alive" as NSObjectProtocol)
        }
        self.ruleSystem.add(rule2)

        let rule3 = GKRule(blockPredicate: { (system: GKRuleSystem) -> Bool in
            let effect = Effect(id: Constants.witch_poison_effect)
            if self.effects.contains(effect) { return true }
            else { return false }
        }) { (system: GKRuleSystem) -> Void in
            system.retractFact("alive" as NSObjectProtocol)
        }
        self.ruleSystem.add(rule3)
    }

    func attachEffect(effect: Effect) {
        self.effects.insert(effect)
    }

    func effectString() -> String {
        var str = "E: "

        for effect in self.effects {
            str += effect.id + " "
        }

        return str

    }

    func settle() -> Bool {
        self.ruleSystem.reset()
        self.ruleSystem.assertFact("alive" as NSObjectProtocol)
        self.ruleSystem.evaluate()

        let grade = self.ruleSystem.grade(forFact: "alive" as NSObjectProtocol)

        return grade == 1
    }

    func isWerewolfKilled() -> Bool {
        let effect = Effect(id: "werewolf_kill_effect")
        
        return self.effects.contains(effect)
    }
    
}
