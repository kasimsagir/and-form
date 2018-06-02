//
//  Poll.swift
//  Albaraka Bizbize
//
//  Created by kasım on 22/11/2017.
//  Copyright © 2017 albaraka. All rights reserved.
//

import Foundation
import SwiftyJSON

class Poll: NSObject {
    
    var id: Int?
    var title: String?
    var date: Double?
    var questions: [PollQuestion]?
    var pollType: String? // GENERAL, EVENT, SESSION
    var sessionName: String?
    
    static func objectMapping(jsonObject: JSON) -> Poll {
        let poll = Poll()
        poll.id = jsonObject["id"].int
        poll.title = jsonObject["title"].string
        poll.date = jsonObject["date"].double
        poll.questions = PollQuestion.objectArrayMapping(jsonObject: jsonObject["questions"])
        poll.pollType = jsonObject["pollType"].string
        if poll.pollType == "SESSION" {
            poll.sessionName = jsonObject["sessionName"].string
        }
        
        return poll
    }
    
    static func objectArrayMapping(jsonObject: JSON) -> [Poll]  {
        var polls = [Poll]()
        
        if let items = jsonObject.array {
            for item in items {
                let poll = objectMapping(jsonObject: item)
                polls.append(poll)
            }
        }
        return polls
    }
}
