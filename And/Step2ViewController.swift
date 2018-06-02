//
//  Step2ViewController.swift
//  And
//
//  Created by kasım on 14.05.2018.
//  Copyright © 2018 Mobistech. All rights reserved.
//

import Foundation
import UIKit

class Step2ViewController: UIViewController {
    @IBOutlet weak var project1Button: UIButton!
    @IBOutlet weak var project2Button: UIButton!
    
    @IBAction func buttonAction(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
        }else {
            sender.isSelected = true
        }
    }
    
    @IBAction func dismissView(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func buttonSelected(_ sender: UIButton) {
        switch sender {
        case project1Button:
            project1Button.isSelected = true
            project2Button.isSelected = false
            break
        case project2Button:
            project1Button.isSelected = false
            project2Button.isSelected = true
            break
            
        default:
            break
        }
    }
}
