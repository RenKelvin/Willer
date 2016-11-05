//
//  Effect.swift
//  Willer
//
//  Created by Chuan Ren on 10/28/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

struct Effect: Hashable {

    var id: String = "Effect:id"

    // Hashable

    public var hashValue: Int {
        return self.id.hash
    }

    // Equalable

    public static func ==(lhs: Effect, rhs: Effect) -> Bool {
        return lhs.id == rhs.id
    }
    
}
