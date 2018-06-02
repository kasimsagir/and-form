//
//  SurveyViewController.swift
//  And
//
//  Created by kasım on 30.05.2018.
//  Copyright © 2018 Mobistech. All rights reserved.
//

import Foundation
import UIKit

class SurveyViewController : UIViewController {
    
    @IBAction func restartAction(_ sender: UIButton) {
        let alert = UIAlertController(title: "Teşekkürler", message: "Ankete katıldığınız için teşekkür ederiz.", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Bitir", style: .default) {
            (result : UIAlertAction) -> Void in
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "startPage")
            self.present(vc!, animated: true, completion: nil)
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
}
