//
//  PlayerMidiator.swift
//  Willer
//
//  Created by Chuan Ren on 10/29/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import UIKit

class PlayerMidiator: NSObject {

    var playerArray = [Player]()

    // MARK: - Singleton
    static let sharedInstance = PlayerMidiator()

    override private init() {
        
    }

    func settle() {

    }

    func alivePlayers() -> [Player] {
        return []
    }

}
