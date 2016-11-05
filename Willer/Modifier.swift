//
//  Modifier.swift
//  Willer
//
//  Created by Chuan Ren on 10/28/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import UIKit

class Modifier: NSObject {

    var id: String = "Modifier:id"

    var targetAmount = 0

    func modify() {
        print(self.id)
    }

    func attachEffect(effect: Effect, targets: [Player]) {
        for target in targets {
            target.effectMachine.attachEffect(effect: effect)
        }
    }
    
}
