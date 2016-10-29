//
//  Step.swift
//  Willer
//
//  Created by Chuan Ren on 10/29/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import UIKit

class Step: NSObject {
    var text1: String?
    var text2: String?

    static func randomStep() -> Step {
        let a = String(arc4random_uniform(UInt32(10)))
        let b = String(arc4random_uniform(UInt32(1000)))

        let step = Step()
        step.text1 = a
        step.text2 = b

        return step
    }
}
