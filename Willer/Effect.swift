//
//  Effect.swift
//  Willer
//
//  Created by Chuan Ren on 10/28/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import SwiftyJSON

class Effect: NSObject {

    var id: String?

    init(json: JSON) {
        self.id = json["id"].string
    }
    
}
