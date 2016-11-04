//
//  JSON+file.swift
//  Willer
//
//  Created by Chuan Ren on 11/4/16.
//  Copyright © 2016 Chuan Ren. All rights reserved.
//

import SwiftyJSON

extension JSON {

    init(file: String) {
        let path = Bundle.main.path(forResource: file, ofType: "json")
        let data = NSData(contentsOfFile: path!)
        self.init(data: data as! Data)
    }
    
}
