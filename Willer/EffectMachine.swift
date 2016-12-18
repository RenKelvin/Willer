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
        // Werewolf kill -> dead
        let rule1 = GKRule(blockPredicate: { (system: GKRuleSystem) -> Bool in
            let effect = Effect(id: Constants.werewolf_kill_effect)
            if self.effects.contains(effect) { return true }
            else { return false }
        }) { (system: GKRuleSystem) -> Void in
            system.retractFact("live" as NSObjectProtocol)
        }
        self.ruleSystem.add(rule1)

        // Witch save -> live
        let rule2 = GKRule(blockPredicate: { (system: GKRuleSystem) -> Bool in
            let effect = Effect(id: Constants.witch_save_effect)
            if self.effects.contains(effect) { return true }
            else { return false }
        }) { (system: GKRuleSystem) -> Void in
            system.assertFact("live" as NSObjectProtocol)
        }
        self.ruleSystem.add(rule2)

        // Witch poison -> dead
        let rule3 = GKRule(blockPredicate: { (system: GKRuleSystem) -> Bool in
            let effect = Effect(id: Constants.witch_poison_effect)
            if self.effects.contains(effect) { return true }
            else { return false }
        }) { (system: GKRuleSystem) -> Void in
            system.retractFact("live" as NSObjectProtocol)
        }
        self.ruleSystem.add(rule3)

        // Hunter shot -> dead
        let rule4 = GKRule(blockPredicate: { (system: GKRuleSystem) -> Bool in
            let effect = Effect(id: Constants.hunter_shot_effect)
            if self.effects.contains(effect) { return true }
            else { return false }
        }) { (system: GKRuleSystem) -> Void in
            system.retractFact("live" as NSObjectProtocol)
        }
        self.ruleSystem.add(rule4)

        // Exile -> dead
        let rule5 = GKRule(blockPredicate: { (system: GKRuleSystem) -> Bool in
            let effect = Effect(id: Constants.exile_effect)
            if self.effects.contains(effect) { return true }
            else { return false }
        }) { (system: GKRuleSystem) -> Void in
            system.retractFact("live" as NSObjectProtocol)
        }
        self.ruleSystem.add(rule5)

        // Werewolf suicide -> dead
        let rule6 = GKRule(blockPredicate: { (system: GKRuleSystem) -> Bool in
            let effect = Effect(id: Constants.werewolf_suicide_effect)
            if self.effects.contains(effect) { return true }
            else { return false }
        }) { (system: GKRuleSystem) -> Void in
            system.retractFact("live" as NSObjectProtocol)
        }
        self.ruleSystem.add(rule6)

    }

    func attachEffect(effect: Effect) {
        self.effects.insert(effect)
    }

    func effectString() -> String {
        var str = ""

        for effect in self.effects {
            str += effect.id + " "
        }

        return str

    }

    func settle() -> Bool {
        self.ruleSystem.reset()
        self.ruleSystem.assertFact("live" as NSObjectProtocol)
        self.ruleSystem.evaluate()

        let grade = self.ruleSystem.grade(forFact: "live" as NSObjectProtocol)

        return grade == 1
    }

    func clean() {
        self.effects = Set(self.effects.filter({!($0.inactive() || $0.lastDayActive())}))
    }

    func isWerewolfKilled() -> Bool {
        let effect = Effect(id: "werewolf_kill_effect")
        
        return self.effects.contains(effect)
    }
    
}
