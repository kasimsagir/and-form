//
//  Id.swift
//  Albaraka Bizbize
//
//  Created by kasım on 02/12/2017.
//  Copyright © 2017 albaraka. All rights reserved.
//

import Foundation
import SwiftyJSON

class Id: NSObject {
    
    var id: Int?
    
    static func objectMapping(jsonObject: JSON) -> Id {
        let id = Id()
        id.id = jsonObject["id"].int
        
        return id
    }
    
    static func objectArrayMapping(jsonObject: JSON) -> [Id]  {
        var ids = [Id]()
        
        if let items = jsonObject.array {
            for item in items {
                let id = objectMapping(jsonObject: item)
                ids.append(id)
            }
        }
        return ids
    }
    
    func toJSON() -> [String: AnyObject] {
        var json = [String: AnyObject]()
        if let id = id {
            json["id"] = id as AnyObject
        }
        return json
    }
    
    static func toJSONArray(ids: [Id]) -> [[String: AnyObject]] {
        var jsonArray = [[String: AnyObject]]()
        for item in ids {
            let id = item.toJSON()
            jsonArray.append(id)
        }
        return jsonArray
    }
}
