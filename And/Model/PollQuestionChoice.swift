//
//  PollQuestionChoice.swift
//  Albaraka Bizbize
//
//  Created by kasım on 22/11/2017.
//  Copyright © 2017 albaraka. All rights reserved.
//

import Foundation
import SwiftyJSON

class PollQuestionChoice: NSObject {
    
    var id: Int?
    var text: String?
    
    static func objectMapping(jsonObject: JSON) -> PollQuestionChoice {
        let pollQuestionChoice = PollQuestionChoice();
        pollQuestionChoice.id = jsonObject["id"].int
        pollQuestionChoice.text = jsonObject["text"].string
        
        return pollQuestionChoice
    }
    
    static func objectArrayMapping(jsonObject: JSON) -> [PollQuestionChoice]  {
        var pollQuestionChoices = [PollQuestionChoice]()
        
        if let items = jsonObject.array {
            for item in items {
                let pollQuestionChoice = objectMapping(jsonObject: item)
                pollQuestionChoices.append(pollQuestionChoice)
            }
        }
        return pollQuestionChoices
    }
}
