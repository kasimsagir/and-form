//
//  Step3ViewController.swift
//  And
//
//  Created by kasım on 14.05.2018.
//  Copyright © 2018 Mobistech. All rights reserved.
//

import Foundation
import UIKit
import WSDL2Swift

class Step3ViewController: UIViewController  {
    
    var count = 0
    
    override func viewDidLoad() {
        loadData()
    }
    
    func loadData(){
        let param = ZCRM_MOBILE_FORM_WS_ZcrmSCreateBpWs.init(NameFirst: "kasim", NameLast: "sagir", Birthdate: "2018-01-01", Sex: "1", MaritalStat: "1", MobileNo: "5332131212", Email: "kas@kaskas.kaskas", Job: "1", Education: "1", Company: "2", Project: "FREKANS", Approval: "X")
        
        postData(param: param)
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {

        if sender.isSelected {
            sender.isSelected = false
            if sender.tag == 1 {
                count -= 1
            }
        }else {
            sender.isSelected = true
            if sender.tag == 1 {
                count += 1
            }
        }
    }
    
    @IBAction func dismissView(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func termAction(_ sender: UIButton) {
        let alertView = UIAlertController(title: "Kullanım Koşulları", message: Constant.termsText, preferredStyle: .alert)
        
        let destructiveAction = UIAlertAction(title: "Kabul Etmiyorum", style: .destructive) {
            (result : UIAlertAction) -> Void in
            sender.isSelected = false
        }
        let okAction = UIAlertAction(title: "Kabul Ediyorum", style: .default) {
            (result : UIAlertAction) -> Void in
            sender.isSelected = true
        }
        alertView.addAction(okAction)
        alertView.addAction(destructiveAction)
        self.present(alertView, animated: true, completion: nil)
    }
    
    func postData(param : ZCRM_MOBILE_FORM_WS_ZcrmSCreateBpWs){
        let client = ZCRM_MOBILE_FORM_WS(endpoint: "http://SSAGYCRMD01.anadolu.corp:8000/sap/bc/srt/rfc/sap/zcrm_mobile_form_ws/200/zcrm_mobile_form_ws/zcrm_mobile_form_ws")
        let request = client.request(ZCRM_MOBILE_FORM_WS_ZcrmCreateMobFormWs(IsData: param))
        request.onComplete{
            (r) in
            print("Test: \(r)")
        }
    }
    
    @IBAction func sendAction(_ sender: UIButton) {
        
        if count == 0 {
            let alert = UIAlertController(title: "Uyarı", message: "Lütfen haberdar olma şekli seçiniz.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Tamam", style: .cancel)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }else {
            let alert = UIAlertController(title: "Teşekkürler", message: "Katıldığınız için teşekkür ederiz. Ankete katılmanızı rica ederiz.", preferredStyle: .alert)
            let destructiveAction = UIAlertAction(title: "Bitir", style: .default){
                (result : UIAlertAction) -> Void in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "startPage")
                self.present(vc!, animated: true, completion: nil)
            }
            let okAction = UIAlertAction(title: "Ankete Katıl", style: .default) {
                (result : UIAlertAction) -> Void in
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SurveyViewController") as! SurveyViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }
            alert.addAction(destructiveAction)
            alert.addAction(okAction)
            
            present(alert, animated: true, completion: nil)
        }
    }
}
