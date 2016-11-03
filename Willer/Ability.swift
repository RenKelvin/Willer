//
//  Ability.swift
//  Willer
//
//  Created by Chuan Ren on 10/28/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import UIKit

class Ability: NSObject {

    var id: String?

    var modifiers: [Modifier] = []

    func perform() {
        for modifier in self.modifiers {
            modifier.perform()
        }
    }

    func action() -> Bool {
        self.perform()
        return true
    }

}
