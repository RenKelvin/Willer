//
//  StatusMidiator.swift
//  Willer
//
//  Created by Chuan Ren on 10/29/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import UIKit

class StatusMidiator: NSObject {

    var currentDay: Int = 0
    var isNight: Bool {
        return self.currentDay%2 == 1
    }

    // MARK: - Singleton
    static let sharedInstance = StatusMidiator()

    override private init() {

    }

    func alternate() {
        self.currentDay += 1
    }
    
}
