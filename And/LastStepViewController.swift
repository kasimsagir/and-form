//
//  LastStepViewController.swift
//  And
//
//  Created by Kasım on 8.11.2018.
//  Copyright © 2018 Mobistech. All rights reserved.
//

import Foundation
import UIKit

class LastStepViewController: UIViewController {
    
    
    @IBAction func cancelAction(_ sender: Any) {
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func surveyAction(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "SurveyViewController") as! SurveyViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
