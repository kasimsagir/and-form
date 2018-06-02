//
//  AnswerRequestModel.swift
//  Albaraka Bizbize
//
//  Created by kasım on 02/12/2017.
//  Copyright © 2017 albaraka. All rights reserved.
//
	

import Foundation
import SwiftyJSON

class AnswerRequestModel: NSObject {
    
    var question = Id()
    var selectedChoices: [Id] = []
    var freeText: String = ""
    
    static func objectMapping(jsonObject: JSON) -> AnswerRequestModel {
        let answerRequestModel = AnswerRequestModel()
        
        answerRequestModel.question = Id.objectMapping(jsonObject: jsonObject["question"])
        answerRequestModel.selectedChoices = Id.objectArrayMapping(jsonObject: jsonObject["selectedChoices"])
        answerRequestModel.freeText = jsonObject["freeText"].string!
        
        return answerRequestModel
    }
    
    static func objectArrayMapping(jsonObject: JSON) -> [AnswerRequestModel]  {
        var answerRequestModels = [AnswerRequestModel]()
        
        if let items = jsonObject.array {
            for item in items {
                let answerRequestModel = objectMapping(jsonObject: item)
                answerRequestModels.append(answerRequestModel)
            }
        }
        return answerRequestModels
    }
    /*
    func toJSON() -> [String: AnyObject] {
        var jsonArray: [[String: AnyObject]] = []
        var temp = [String: AnyObject]()
        var json = [String: AnyObject]()
        
        json["question"] = question.toJSON()
        if selectedChoices.count > 0 {
            for item in selectedChoices {
                temp = item.toJSON()
                jsonArray.append(temp)  
            }
            json["selectedChoices"] = jsonArray
        }
        if freeText != "" {
            json["freeText"] = freeText
        }
        return json
    }
    
    static func toJSONArray(answerRequestModels: [AnswerRequestModel]) -> [[String: AnyObject]] {
        var jsonArray = [[String: AnyObject]]()
        for item in answerRequestModels {
            if item.freeText != "" || item.selectedChoices.count != 0 {
                let answerRequestModel = item.toJSON()
                jsonArray.append(answerRequestModel)
            }
        }
        return jsonArray
    }*/
    
}

