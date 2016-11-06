//
//  Effect.swift
//  Willer
//
//  Created by Chuan Ren on 10/28/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

// pending -> active -> inactive

struct Effect: Hashable {

    var id: String = "Effect:id"

    var delay: Int = 0
    var duration: Int = 1

    var attached: Int = 0

    init(id: String = "Effect:id", delay: Int = 0, duration: Int = 1) {
        self.id = id
        self.delay = delay
        self.duration = duration
    }

    static func factory(id: String) -> Effect {
        switch id {

        case Constants.werewolf_kill_effect:
            return Effect(id: Constants.werewolf_kill_effect, delay: 0, duration: 1)

        case Constants.witch_save_effect:
            return Effect(id: Constants.witch_save_effect, delay: 0, duration: 1)

        case Constants.witch_poison_effect:
            return Effect(id: Constants.witch_poison_effect, delay: 0, duration: 1)

        default:
            return Effect()
        }
    }

    func lastDayActive() -> Bool {
        let day = StatusMidiator.sharedInstance.currentDay
        return day == self.attached + self.delay + self.duration - 1
    }

    func inactive() -> Bool {
        let day = StatusMidiator.sharedInstance.currentDay
        return day > self.attached + self.delay + self.duration - 1
    }

    // Hashable

    public var hashValue: Int {
        return self.id.hash
    }

    // Equalable

    public static func ==(lhs: Effect, rhs: Effect) -> Bool {
        return lhs.id == rhs.id
    }
    
}
