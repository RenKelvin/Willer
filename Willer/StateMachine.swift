//
//  StateMachine.swift
//  Willer
//
//  Created by Chuan Ren on 11/4/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import UIKit

class StateMachine: NSObject {

    enum State {
        case live
        case dying
        case dead
    }

    var living: Bool {
        return self.state == .live || self.state == .dying
    }

    var state: State = .live

    var selected: Bool = false
    
}
