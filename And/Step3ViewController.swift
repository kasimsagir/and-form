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
import TextFieldEffects

class Step3ViewController: UIViewController  {
    
    @IBOutlet weak var informedTypeTextField: HoshiTextField!
    @IBOutlet weak var termButton: UIButton!
    
    var dismissProblem = true
    
    override func viewDidLoad() {
        let myMutableString = NSMutableAttributedString(string: (termButton.titleLabel?.text)!, attributes: nil)
        myMutableString.addAttribute(.foregroundColor, value: UIColor.blue, range: NSRange(location:33,length:8))
        termButton.titleLabel?.attributedText = myMutableString
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = true
    }
    
    override func viewDidAppear(_ animated: Bool) {
        reloadDataFromUserDefaults()
    }
    
    @IBAction func informedTypeTextFieldAction(_ sender: HoshiTextField) {
        if dismissProblem { // Sayfaya gidip geri gelince yine bu actiona giriyordu onu engellemek için dismissProblem değişkenini kulandım.
            dismissProblem = false
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "InformedTypeTableViewController") as! InformedTypeTableViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }else {
            dismissProblem = true
            view.endEditing(true)
        }
    }
    
    func reloadDataFromUserDefaults(){
        informedTypeTextField.text = UserUtils.getInformedTypeValue()
        if UserUtils.getInformedTypeDetail() != "" {
            informedTypeTextField.text?.append(" - "+UserUtils.getInformedTypeDetailValue())
        }
        if UserUtils.getApproval() == "X" {
            termButton.isSelected = true
        }else {
            termButton.isSelected = false
        }
    }
    
    func getPostData()->ZCRM_MOBILE_FORM_WS_ZcrmSCreateBpWs{
        
        
        return ZCRM_MOBILE_FORM_WS_ZcrmSCreateBpWs.init(NameFirst: UserUtils.getNameFirst(), NameLast: UserUtils.getNameLast(), Birthdate: UserUtils.getFormatBirthdate(), Sex: UserUtils.getSex(), MaritalStat: UserUtils.getMaritalStat(), MobileNo: formatPhoneNumber(number: UserUtils.getMobileNo()), Email: UserUtils.getEmail(), Job: UserUtils.getJob(), Education: UserUtils.getEducation(), Company: UserUtils.getCompany(), Project: UserUtils.getProject(), Approval: UserUtils.getApproval(), Country: UserUtils.getCountry(), Region: UserUtils.getRegion(), City: UserUtils.getCityDetail(), County: UserUtils.getCity(), Street: UserUtils.getStreet(), HouseNo: UserUtils.getHouseNo(), PostCode: UserUtils.getPostCode(), Township: UserUtils.getTown(), DaireTip1: UserUtils.getApartmentType1(), DaireTip2: UserUtils.getApartmentType2(), DaireTip3: UserUtils.getApartmentType3(), DaireTip4: UserUtils.getApartmentType4(), DaireTip5: UserUtils.getApartmentType5(), SatinAmac: UserUtils.getPurposeType(), OdemeTercih: UserUtils.getPayType(), AnaKaynak: "", Kaynak: "")
    }
    
    func formatPhoneNumber(number: String) -> String{
        var phoneNumber = number
        if let index = phoneNumber.index(of: ")") {
            phoneNumber.remove(at: index)
        }
        phoneNumber.remove(at: phoneNumber.startIndex)
        phoneNumber.insert("0", at: phoneNumber.startIndex)
        return phoneNumber
    }
    
    @IBAction func dismissView(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func openTermsAction(_ sender: UIButton) {
        /*
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "TermsViewController") as! TermsViewController
        let popvc = vc.popoverPresentationController
        popvc?.permittedArrowDirections = UIPopoverArrowDirection.any
        self.navigationController?.pushViewController(vc, animated: true)
        */
        /*
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
         */
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
                
                let alert = UIAlertController(title: "Teşekkürler", message: "Formunuz başarıyla gönderildi. Size daha iyi hizmet verebilmek için düşünceleriniz bizim için çok  önemli.  Bizi değerlendirmek isterseniz kısa anketimizi doldurmak için ankete katıl butonuna tıklayabilirsiniz.", preferredStyle: .alert)
                let destructiveAction = UIAlertAction(title: "Vazgeç", style: .default){
                    (result : UIAlertAction) -> Void in
                    UserUtils.resetUser()
                    UserUtils.setObjectId(ObjectId: r.value?.EvObjectId ?? "")
                    //let vc = self.storyboard?.instantiateViewController(withIdentifier: "ViewController") as! ViewController
                    self.navigationController?.popToRootViewController(animated: true)
                }
                let okAction = UIAlertAction(title: "Ankete Katıl", style: .default) {
                    (result : UIAlertAction) -> Void in
                    UserUtils.resetUser()
                    UserUtils.setObjectId(ObjectId: r.value?.EvObjectId ?? "")
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "SurveyViewController") as! SurveyViewController
                    self.navigationController?.pushViewController(vc, animated: true)
                }
                alert.addAction(destructiveAction)
                alert.addAction(okAction)
                
                self.present(alert, animated: true, completion: nil)
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
            let alert = UIAlertController(title: "Teşekkürler", message: "Formu doldurduğunuz için teşekkür ederiz.", preferredStyle: .alert)
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
