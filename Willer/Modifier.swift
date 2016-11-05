//
//  Modifier.swift
//  Willer
//
//  Created by Chuan Ren on 10/28/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import SwiftyJSON

class Modifier: NSObject {

    var id: String?

    // MARK: -

    static func factory(json: JSON) -> Modifier? {
        let type = ModifierType(rawValue: json["type"].stringValue)

        if let type = type {
            switch type {
            case .attachEffect:
                return AttachEffectModifier(json: json)

            case .takeAction:
                return TakeActionModifier(json: json)
            }
        }

        return nil
    }

    override init() {

    }

    init(json: JSON) {

    }

    // MARK: -
    
    func perform() {
        
    }
    
}

enum ModifierType: String {
    case attachEffect = "AttachEffect"
    case takeAction = "TakeAction"
}
