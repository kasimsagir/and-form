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
import PKHUD

class Step3ViewController: UIViewController  {
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var button5: UIButton!
    @IBOutlet weak var button6: UIButton!
    @IBOutlet weak var button7: UIButton!
    @IBOutlet weak var button8: UIButton!
    @IBOutlet weak var button9: UIButton!
    @IBOutlet weak var button10: UIButton!
    @IBOutlet weak var termButton: UIButton!
    
    override func viewDidLoad() {
        reloadDataFromUserDefaults()
        
        let myMutableString = NSMutableAttributedString(string: (termButton.titleLabel?.text)!, attributes: nil)
        myMutableString.addAttribute(.foregroundColor, value: UIColor.blue, range: NSRange(location:33,length:8))
        termButton.titleLabel?.attributedText = myMutableString
        
    }
    
    func reloadDataFromUserDefaults(){
        if UserUtils.getApproval() == "X" {
            termButton.isSelected = true
        }else {
            termButton.isSelected = false
        }
        
        switch UserUtils.getInformedType() {
        case "12":
            button1.isSelected = true
        case "2":
            button2.isSelected = true
        case "6":
            button3.isSelected = true
        case "1":
            button4.isSelected = true
        case "4":
            button5.isSelected = true
        case "11":
            button6.isSelected = true
        case "7":
            button7.isSelected = true
        case "5":
            button8.isSelected = true
        case "8":
            button9.isSelected = true
        case "9":
            button10.isSelected = true
            
        default:
            Utils.deselectButtons(buttons: [button1,button2,button3,button4,button5,button6,button7,button8,button9,button10])
            break
        }
    }
    
    func getPostData()->ZCRM_MOBILE_FORM_WS_ZcrmSCreateBpWs{
        return ZCRM_MOBILE_FORM_WS_ZcrmSCreateBpWs.init(NameFirst: UserUtils.getNameFirst(), NameLast: UserUtils.getNameLast(), Birthdate: UserUtils.getFormatBirthdate(), Sex: UserUtils.getSex(), MaritalStat: UserUtils.getMaritalStat(), MobileNo: formatPhoneNumber(number: UserUtils.getMobileNo()), Email: UserUtils.getEmail(), Job: UserUtils.getJob(), Education: UserUtils.getEducation(), Company: UserUtils.getCompany(), Project: UserUtils.getProject(), Approval: UserUtils.getApproval(), Country: UserUtils.getCountry(), Region: UserUtils.getRegion(), City: UserUtils.getCityDetail(), County: UserUtils.getCity(), Street: UserUtils.getStreet(), HouseNo: UserUtils.getHouseNo(), PostCode: UserUtils.getPostCode(), Township: UserUtils.getTown(), DaireTip1: UserUtils.getApartmentType1(), DaireTip2: UserUtils.getApartmentType2(), DaireTip3: UserUtils.getApartmentType3(), DaireTip4: UserUtils.getApartmentType4(), SatinAmac: UserUtils.getPurposeType(), OdemeTercih: UserUtils.getPayType(), HaberdarOlma: UserUtils.getInformedType())
    }
    
    func formatPhoneNumber(number: String) -> String{
        var phoneNumber = number
        phoneNumber.remove(at: phoneNumber.index(of: ")")!)
        phoneNumber.remove(at: phoneNumber.startIndex)
        phoneNumber.insert("0", at: phoneNumber.startIndex)
        return phoneNumber
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        Utils.deselectButtons(buttons: [button1,button2,button3,button4,button5,button6,button7,button8,button9,button10])
        sender.isSelected = true
        UserUtils.setInformedType(InformedType: String(sender.tag))
    }
    
    @IBAction func dismissView(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func openTermsAction(_ sender: UIButton) {
        let alertView = UIAlertController(title: "Kullanım Koşulları", message: Constant.termsText, preferredStyle: .alert)
        
        let destructiveAction = UIAlertAction(title: "Kabul Etmiyorum", style: .destructive) {
            (result : UIAlertAction) -> Void in
            self.termButton.isSelected = false
            UserUtils.setApproval(Approval: "")
        }
        let okAction = UIAlertAction(title: "Kabul Ediyorum", style: .default) {
            (result : UIAlertAction) -> Void in
            self.termButton.isSelected = true
            UserUtils.setApproval(Approval: "X")
        }
        alertView.addAction(okAction)
        alertView.addAction(destructiveAction)
        self.present(alertView, animated: true, completion: nil)
    }
    @IBAction func termAction(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            UserUtils.setApproval(Approval: "")
        }else {
            sender.isSelected = true
            UserUtils.setApproval(Approval: "X")
        }
    }
    
    func callFormServiceToSurvey(){
        PKHUD.sharedHUD.show()
        let client = ZCRM_MOBILE_FORM_WS(endpoint: "http://SSAGYCRMD01.anadolu.corp:8000/sap/bc/srt/rfc/sap/zcrm_mobile_form_ws/200/zcrm_mobile_form_ws/zcrm_mobile_form_ws")
        let request = client.request(ZCRM_MOBILE_FORM_WS_ZcrmCreateMobFormWs(IsData: getPostData()))
        request.onComplete{
            (r) in
            PKHUD.sharedHUD.hide()
            if (r.value?.EtReturn.item[0].Type == "S") {
                UserUtils.resetUser()
                UserUtils.setObjectId(ObjectId: r.value?.EvObjectId ?? "")
                let vc = self.storyboard?.instantiateViewController(withIdentifier: "SurveyViewController") as! SurveyViewController
                self.navigationController?.pushViewController(vc, animated: true)
            }else {
                let alert = UIAlertController(title: "Hata", message: "Sunucuya bağlanamadı.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Tamam", style: .cancel)
                let tryAction = UIAlertAction(title: "Tekrar Dene", style: .default) {
                    (result : UIAlertAction) -> Void in
                    self.callFormServiceToSurvey()
                }
                alert.addAction(okAction)
                alert.addAction(tryAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @IBAction func sendAction(_ sender: UIButton) {
        
        if UserUtils.getInformedType() == "" {
            let alert = UIAlertController(title: "Uyarı", message: "Lütfen haberdar olma şekli seçiniz.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Tamam", style: .cancel)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }else {
            let alert = UIAlertController(title: "Teşekkürler", message: "Katıldığınız için teşekkür ederiz. Göndermek için devam ediniz.", preferredStyle: .alert)
            let destructiveAction = UIAlertAction(title: "Vazgeç", style: .default)
            let okAction = UIAlertAction(title: "Devam Et", style: .default) {
                (result : UIAlertAction) -> Void in
                self.callFormServiceToSurvey()
            }
            alert.addAction(destructiveAction)
            alert.addAction(okAction)
            
            present(alert, animated: true, completion: nil)
        }
    }
}
