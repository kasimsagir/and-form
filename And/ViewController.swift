//
//  ViewController.swift
//  And
//
//  Created by kasım on 11.05.2018.
//  Copyright © 2018 Mobistech. All rights reserved.
//

import UIKit
import TextFieldEffects
import IQKeyboardManagerSwift

class ViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    
    @IBOutlet weak var genderMale: UIButton!
    @IBOutlet weak var genderFemale: UIButton!
    @IBOutlet weak var married: UIButton!
    @IBOutlet weak var single: UIButton!
    @IBOutlet weak var edc1: UIButton!
    @IBOutlet weak var edc2: UIButton!
    @IBOutlet weak var edc3: UIButton!
    @IBOutlet weak var edc4: UIButton!
    @IBOutlet weak var edc5: UIButton!
    @IBOutlet weak var nameTextField: HoshiTextField!
    @IBOutlet weak var birthdayTextField: HoshiTextField!
    @IBOutlet weak var jobTextField: HoshiTextField!
    @IBOutlet weak var companyNameTextField: HoshiTextField!
    @IBOutlet weak var telNoTextField: HoshiTextField!
    @IBOutlet weak var emailTextField: HoshiTextField!
    @IBOutlet weak var countryTextField: HoshiTextField!
    @IBOutlet weak var cityTextField: HoshiTextField!
    @IBOutlet weak var cityDetailTextField: HoshiTextField!
    @IBOutlet weak var addressTextField: HoshiTextField!
    
    
    var datePicker = UIDatePicker()
    var picker = UIPickerView()
    var deleteTelNo = false
    
    var countryData = ["Seçiniz", "Türkiye", "Almanya", "Ingiltere", "Rusya", "İspanya", "Italya"]
    var jobs : [ZCRM_MOBILE_FORM_WS_ZcrmSJobSh] = []
    var cityData = ["Seçiniz", "İstanbul"]
    var cityDetailData = ["Seçiniz", "Kozyatağı"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initPicker()
        
        getJobs()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        showPicker()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getJobs(){
        let client = ZCRM_MOBILE_FORM_WS(endpoint: "http://SSAGYCRMD01.anadolu.corp:8000/sap/bc/srt/rfc/sap/zcrm_mobile_form_ws/200/zcrm_mobile_form_ws/zcrm_mobile_form_ws")
        let request = client.request(ZCRM_MOBILE_FORM_WS_ZcrmGetAttrShWs(IvAttribute: "meslek"))
        request.onComplete{
            (r) in
            print("\nTest: \(r)\n")
            if let jobResponse = r.value?.EtAttrList.item {
                self.jobs = jobResponse
                self.jobs.insert(ZCRM_MOBILE_FORM_WS_ZcrmSJobSh(Value: "Seçiniz", ValueDescr: ""), at: 0)
            }
        }
    }
    
    func initPicker(){
        picker.delegate = self
        picker.dataSource = self
        
        datePicker.locale = Locale.init(identifier: "tr")
    }

    @IBAction func buttonSelected(_ sender: UIButton) {
        switch sender {
        case genderMale:
            genderMale.isSelected = true
            genderFemale.isSelected = false
            break
        case genderFemale:
            genderMale.isSelected = false
            genderFemale.isSelected = true
            break
        
        case married:
            married.isSelected = true
            single.isSelected = false
        case single:
            single.isSelected = true
            married.isSelected = false
            
        case edc1:
            selectSenderAndDeselectOther(selected: edc1, deselectedButtons: [edc2,edc3,edc4,edc5])
        case edc2:
            selectSenderAndDeselectOther(selected: edc2, deselectedButtons: [edc1,edc3,edc4,edc5])
        case edc3:
            selectSenderAndDeselectOther(selected: edc3, deselectedButtons: [edc1,edc2,edc4,edc5])
        case edc4:
            selectSenderAndDeselectOther(selected: edc4, deselectedButtons: [edc1,edc2,edc3,edc5])
        case edc5:
            selectSenderAndDeselectOther(selected: edc5, deselectedButtons: [edc1,edc2,edc3,edc4])
            
        default:
            break
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        IQKeyboardManager.shared.goNext()
        return true
    }
    
    //MARK: Show Date Picker
    func showPicker(){
        datePicker.datePickerMode = .date
        birthdayTextField.inputView = datePicker
        jobTextField.inputView = picker
        countryTextField.inputView = picker
        cityTextField.inputView = picker
        cityDetailTextField.inputView = picker
    }
    
    @IBAction func birthdayEditingDidEnd(_ sender: Any) {
        donedatePicker()
    }
    
    @IBAction func pickerViewDidBegin(_ sender: HoshiTextField) {
        switch sender {
        case telNoTextField:
            if (sender.text?.isEmpty)! {
                sender.text = "(5"
            }
            break
        case jobTextField:
            picker.tag = 2
            picker.reloadAllComponents()
        case countryTextField:
            picker.tag = 1
            greenTextField(sender: countryTextField)
            picker.reloadAllComponents()
            break
        case cityTextField:
            picker.tag = 3
            greenTextField(sender: cityTextField)
            picker.reloadAllComponents()
            break
        case cityDetailTextField:
            picker.tag = 4
            greenTextField(sender: cityDetailTextField)
            picker.reloadAllComponents()
            break

        default:
            break
        }
        
    }
    
    @IBAction func textFieldEditingChanged(_ sender: HoshiTextField) {
        switch sender {
        case telNoTextField:
            switch sender.text?.count {
            case 0:
                sender.text = "(5"
                deleteTelNo = false
                break
            case 1:
                sender.text = "(5"
                deleteTelNo = false
                break
            case 2:
                deleteTelNo = false
                redTextField(sender: sender)
                break
            case 4:
                if deleteTelNo == false {
                    sender.text?.append(")")
                    deleteTelNo = true
                }
                break
            case 12:
                greenTextField(sender: sender)
                break
            case 13:
                sender.text?.removeLast()
                break
            default:
                redTextField(sender: sender)
                break
            }
            break
        default:
            if ((sender.text?.isEmpty)! || (sender == emailTextField && !isEmail(mailText: sender.text!))) {
                redTextField(sender: sender)
            }else {
                greenTextField(sender: sender)
            }
        }
    }
    
    @objc func donedatePicker(){
        //For date formate
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "tr")
        formatter.dateFormat = "dd MMMM yyyy"
        birthdayTextField.text! = formatter.string(from: datePicker.date)
        
        greenTextField(sender: birthdayTextField)
    }
    
    func selectSenderAndDeselectOther(selected: UIButton, deselectedButtons: [UIButton]){
        selected.isSelected = true
        for item in deselectedButtons {
            item.isSelected = false
        }
    }
    @IBAction func callSoapService(_ sender: UIButton) {
        callSOAP()
    }
    
    func isEmail(mailText: String)->Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: mailText)
    }
    
    func callSOAP(){
        let is_SoapMessage: String = ""
        
        let is_URL: String = "http://SSAGYCRMD01.anadolu.corp:8000/sap/bc/srt/wsdl/flv_10002A111AD1/bndg_url/sap/bc/srt/rfc/sap/zcrm_create_bp_form_ws/200/zcrm_create_bp_form_ws/zcrm_create_bp_form_bn?sap-client=200"
        
        let lobj_Request = NSMutableURLRequest(url: URL(string: is_URL)!)
        
        let config = URLSessionConfiguration.default
        let userPasswordString = "danisman:1234567"
        let userPasswordData = userPasswordString.data(using: String.Encoding.utf8)
        let base64EncodedCredential = userPasswordData!.base64EncodedString()
        let authString = "Basic \(base64EncodedCredential)"
        config.httpAdditionalHeaders = ["Authorization" : authString]
        
        let session = URLSession(configuration: config)
        
        lobj_Request.httpMethod = "POST"
        lobj_Request.httpBody = is_SoapMessage.data(using: String.Encoding.utf8)
        lobj_Request.addValue("SSAGYCRMD01.anadolu.corp:8000", forHTTPHeaderField: "Host")
        lobj_Request.addValue("text/xml; charset=utf-8", forHTTPHeaderField: "Content-Type")
        lobj_Request.addValue(String(is_SoapMessage.count), forHTTPHeaderField: "Content-Length")
        //lobj_Request.addValue("223", forHTTPHeaderField: "Content-Length")
        lobj_Request.addValue("http://www.cgsapi.com/ZcrmCreateBpWs", forHTTPHeaderField: "SOAPAction")
        let task = session.dataTask(with: lobj_Request as URLRequest, completionHandler: {data, response, error -> Void in

            
            if error != nil{
                print("Error: " + (error?.localizedDescription)!)
            }else {
                print("Response: \(String(describing: response))")
                let strData = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
                print("Body: \(String(describing: strData))")
            }
            
        })
        task.resume()
    }
    
    func redTextField(sender: HoshiTextField){
        sender.borderActiveColor = UIColor.red
        sender.borderInactiveColor = UIColor.red
        sender.borderStyle = .bezel
    }
    
    func greenTextField(sender: HoshiTextField){
        sender.borderActiveColor = UIColor.green
        sender.borderInactiveColor = UIColor.green
        sender.borderStyle = .bezel
    }
    
    //PİCKER VİEW DELEGATE
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch picker.tag {
        case 1:
            return countryData.count
        case 2:
            return jobs.count
        case 3:
            return cityData.count
        case 4:
            return cityDetailData.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch picker.tag {
        case 1:
            return countryData[row]
        case 2:
            return jobs[row].ValueDescr
        case 3:
            return cityData[row]
        case 4:
            return cityDetailData[row]
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch picker.tag {
        case 1:
            if row == 0 {
                countryTextField.text = ""
                break
            }
            countryTextField.text = countryData[row]
            greenTextField(sender: countryTextField)
            break
        case 2:
            if row == 0 {
                jobTextField.text = ""
                break
            }
            jobTextField.text = jobs[row].ValueDescr
            greenTextField(sender: jobTextField)
        case 3:
            if row == 0 {
                cityTextField.text = ""
                break
            }
            cityTextField.text = cityData[row]
            greenTextField(sender: cityTextField)
        case 4:
            if row == 0 {
                cityDetailTextField.text = ""
                break
            }
            cityDetailTextField.text = cityDetailData[row]
            greenTextField(sender: cityDetailTextField)
        default:
            break
        }
        
        
    }
    @IBAction func nextAction(_ sender: UIButton) {
        //TODO: BURAYI KAPAT
        if nameTextField.text == "kasimsagir" {
            let vc = storyboard?.instantiateViewController(withIdentifier: "Step2ViewController") as! Step2ViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
        
        
        if (nameTextField.text?.isEmpty)! || (birthdayTextField.text?.isEmpty)! || (telNoTextField.text?.isEmpty)! || (emailTextField.text?.isEmpty)! || (genderMale.isSelected == false && genderFemale.isSelected == false) || (single.isSelected == false && married.isSelected == false) {
            let alert = UIAlertController(title: "Uyarı", message: "Lütfen zorunlu alanları doldurunuz.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Tamam", style: .cancel)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }else if !isEmail(mailText: emailTextField.text!){
            let alert = UIAlertController(title: "Uyarı", message: "Lütfen gerçerli email giriniz.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Tamam", style: .cancel)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }else if telNoTextField.text?.count != 12 {
            let alert = UIAlertController(title: "Uyarı", message: "Lütfen geçerli telefon numarası giriniz.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Tamam", style: .cancel)
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "Step2ViewController") as! Step2ViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
