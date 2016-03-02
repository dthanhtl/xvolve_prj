//
//  ReviewObject.swift
//  HeardSample
//
//  Created by Thanh Tran on 3/3/16.
//  Copyright © 2016 XVolve. All rights reserved.
//

import UIKit


struct ReviewObject {
    
    var conversation_id: String
    var rating_stars: Int
    var comment: String
    var tip: Float
    var _id: String
    
    init(convoID:String, stars:Int, comment:String, tip: Float, ọbjID: String) {
        self.conversation_id = convoID
        self.rating_stars = stars
        self.comment = comment
        self.tip = tip
        self._id = ọbjID
    }
    
}
