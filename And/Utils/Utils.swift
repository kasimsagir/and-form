//
//  Utils.swift
//  And
//
//  Created by kasım on 9.06.2018.
//  Copyright © 2018 Mobistech. All rights reserved.
//

import Foundation
import UIKit

class Utils {
    
    
    static func deselectButtons(buttons: [UIButton]){
        for item in buttons {
            item.isSelected = false
        }
    }
    
    static func stringToColorfulMutableString(mergedString: String, mutableString: String, mutableStringColor: UIColor, otherMergedString: String)->NSMutableAttributedString{
        let myMutableString = NSMutableAttributedString(string: mergedString+mutableString+otherMergedString, attributes: nil)
        myMutableString.addAttribute(.foregroundColor, value: mutableStringColor, range: NSRange(location:mergedString.count,length:mutableString.count))
        return myMutableString
    }
    
}
