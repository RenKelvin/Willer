//
//  Townsfolk.swift
//  Willer
//
//  Created by Chuan Ren on 11/4/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import UIKit

class Townsfolk: Character {

    override init() {
        super.init()

        self.id = "Townsfolk"
        self.name = "普通村民"

        self.abilities = [:]
    }

}

extension Constants {
    static let Townsfolk = "Townsfolk"
}
