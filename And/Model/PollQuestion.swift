//
//  PollQuestion.swift
//  Albaraka Bizbize
//
//  Created by kasım on 22/11/2017.
//  Copyright © 2017 albaraka. All rights reserved.
//

import Foundation
import SwiftyJSON

class PollQuestion: NSObject {
    
    var id: Int?
    var questionText: String?
    var choiceType: String? // SingleChoice, Text
    var choices: [PollQuestionChoice]?
    
    static func objectMapping(jsonObject: JSON) -> PollQuestion {
        let pollQuestion = PollQuestion()
        pollQuestion.id = jsonObject["id"].int
        pollQuestion.questionText = jsonObject["questionText"].string
        pollQuestion.choiceType = jsonObject["choiceType"].string
        pollQuestion.choices = PollQuestionChoice.objectArrayMapping(jsonObject: jsonObject["choices"])
        
        return pollQuestion
    }
    
    static func objectArrayMapping(jsonObject: JSON) -> [PollQuestion]  {
        var pollQuestions = [PollQuestion]()
        
        if let items = jsonObject.array {
            for item in items {
                let pollQuestion = objectMapping(jsonObject: item)
                pollQuestions.append(pollQuestion)
            }
        }
        return pollQuestions
    }
}
