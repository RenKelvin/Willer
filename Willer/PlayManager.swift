//
//  PlayManager.swift
//  Willer
//
//  Created by Chuan Ren on 10/28/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import UIKit

class PlayManager: NSObject {

    var playerArray = [Player]()

    // Singleton
    static let sharedInstance = PlayManager()

    override private init() {
        // Add 2 players
        let player1 = Player()
        player1.no = 1

        let player2 = Player()
        player2.no = 2

        self.playerArray.append(player1)
        self.playerArray.append(player2)

        //
        
    }

}
