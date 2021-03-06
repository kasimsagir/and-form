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
import PKHUD

class ViewController: UIViewController, UITextFieldDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var genderLabel: UILabel!
    @IBOutlet weak var martialStateLabel: UILabel!
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
    @IBOutlet weak var townTextField: HoshiTextField!
    @IBOutlet weak var townDetailTextField: HoshiTextField!
    @IBOutlet weak var streetTextField: HoshiTextField!
    @IBOutlet weak var houseNumberTextField: HoshiTextField!
    @IBOutlet weak var postCodeTextField: HoshiTextField!
    
    var datePicker = UIDatePicker()
    var picker = UIPickerView()
    static var deleteTelNo = false
    static var firstTime = true
    var dismissProblem = true
    
    var countryData : [ZCRM_MOBILE_FORM_WS_BspWdDropdownLine] = []
    var jobs : [ZCRM_MOBILE_FORM_WS_ZcrmSJobSh] = []
    var cityData : [ZCRM_MOBILE_FORM_WS_BspWdDropdownLine] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initPicker()
        getJobs()
        showPicker()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        reloadDataFromUserDefaults()
        self.navigationController?.setNavigationBarHidden(true, animated: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func reloadDataFromUserDefaults(){
        if UserUtils.getNameLast() == "" {
            nameTextField.text = UserUtils.getNameFirst()+""+UserUtils.getNameLast()
        }else {
            nameTextField.text = UserUtils.getNameFirst()+" "+UserUtils.getNameLast()
        }
        birthdayTextField.text = UserUtils.getBirthdate()
        jobTextField.text = UserUtils.getJobDescription()
        companyNameTextField.text = UserUtils.getCompany()
        telNoTextField.text = UserUtils.getMobileNo()
        emailTextField.text = UserUtils.getEmail()
        countryTextField.text = UserUtils.getCountryName()
        cityTextField.text = UserUtils.getRegionName()
        cityDetailTextField.text = UserUtils.getCity()
        townTextField.text = UserUtils.getCityDetail()
        townDetailTextField.text = UserUtils.getTown()
        streetTextField.text = UserUtils.getStreet()
        houseNumberTextField.text = UserUtils.getHouseNo()
        postCodeTextField.text = UserUtils.getPostCode()
        getCountry()
        if UserUtils.getCountry() != "" {
            getCity(countryCode: UserUtils.getCountry())
        }
        
        switch UserUtils.getSex() {
        case "1":   //Kadın
            genderMale.isSelected = false
            genderFemale.isSelected = true
            break
        case "2":
            genderMale.isSelected = true
            genderFemale.isSelected = false
            break
        default:
            genderMale.isSelected = false
            genderFemale.isSelected = false
        }
        switch UserUtils.getMaritalStat() {
        case "0"://Bekar
            single.isSelected = true
            married.isSelected = false
            break
        case "1"://Evli
            married.isSelected = true
            single.isSelected = false
            break
        default:
            single.isSelected = false
            married.isSelected = false
        }
        switch UserUtils.getEducation() {
        case "01":
            selectSenderAndDeselectOther(selected: edc1, deselectedButtons: [edc2,edc3,edc4,edc5])
            break
        case "02":
            selectSenderAndDeselectOther(selected: edc2, deselectedButtons: [edc1,edc3,edc4,edc5])
            break
        case "03":
            selectSenderAndDeselectOther(selected: edc3, deselectedButtons: [edc1,edc2,edc4,edc5])
            break
        case "04":
            selectSenderAndDeselectOther(selected: edc4, deselectedButtons: [edc1,edc2,edc3,edc5])
            break
        case "05":
            selectSenderAndDeselectOther(selected: edc5, deselectedButtons: [edc1,edc2,edc3,edc4])
            break
        default:
            deselectAll(deselectedButtons: [edc1,edc2,edc3,edc4,edc5])
        }
        
    }
    
    func getJobs(){
        let client = ZCRM_MOBILE_FORM_WS(endpoint: "http://SSAGYCRMD01.anadolu.corp:8000/sap/bc/srt/rfc/sap/zcrm_mobile_form_ws/200/zcrm_mobile_form_ws/zcrm_mobile_form_ws")
        let request = client.request(ZCRM_MOBILE_FORM_WS_ZcrmGetAttrShWs(IvAttribute: "meslek"))
        request.onComplete{
            (r) in
            if let jobResponse = r.value?.EtAttrList.item {
                self.jobs = jobResponse
                self.jobs.insert(ZCRM_MOBILE_FORM_WS_ZcrmSJobSh(Value: "", ValueDescr: "-"), at: 0)
            }
        }
    }
    
    func getCountry(){
        PKHUD.sharedHUD.show()
        let client = ZCRM_MOBILE_FORM_WS(endpoint: "http://SSAGYCRMD01.anadolu.corp:8000/sap/bc/srt/rfc/sap/zcrm_mobile_form_ws/200/zcrm_mobile_form_ws/zcrm_mobile_form_ws")
        let request = client.request(ZCRM_MOBILE_FORM_WS_ZcrmGetFieldShWs(IvAnaKaynak: "", IvCountry: "", IvFieldname: "COUNTRY", IvRegion: ""))
        
        request.onComplete{
            (r) in
            PKHUD.sharedHUD.hide()
            if let countryResponse = r.value?.EtValues.item {
                self.countryData = countryResponse
                self.countryData.insert(ZCRM_MOBILE_FORM_WS_BspWdDropdownLine(Key: "", Value: "-"), at: 0)
            }
        }
    }
    
    func getCity(countryCode: String){
        PKHUD.sharedHUD.show()
        let client = ZCRM_MOBILE_FORM_WS(endpoint: "http://SSAGYCRMD01.anadolu.corp:8000/sap/bc/srt/rfc/sap/zcrm_mobile_form_ws/200/zcrm_mobile_form_ws/zcrm_mobile_form_ws")
        let request = client.request(ZCRM_MOBILE_FORM_WS_ZcrmGetFieldShWs(IvAnaKaynak: "", IvCountry: countryCode, IvFieldname: "REGION", IvRegion: ""))
        
        request.onComplete{
            (r) in
            PKHUD.sharedHUD.hide()
            if let cityResponse = r.value?.EtValues.item {
                self.cityData = cityResponse
                self.cityData.insert(ZCRM_MOBILE_FORM_WS_BspWdDropdownLine(Key: "", Value: "-"), at: 0)
                self.picker.reloadComponent(1)
                if self.cityData.count > 1 {
                    self.picker.selectRow(1, inComponent: 1, animated: false)
                    UserUtils.setRegion(Region: self.cityData[1].Key)
                    UserUtils.setRegionName(RegionName: self.cityData[1].Value)
                    self.cityTextField.text = self.cityData[1].Value
                    self.greenTextField(sender: self.cityTextField)
                }else {
                    self.cityTextField.text = ""
                    UserUtils.setRegion(Region: "")
                    UserUtils.setRegionName(RegionName: "")
                }

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
            UserUtils.setSex(Sex: "2")
            break
        case genderFemale:
            genderMale.isSelected = false
            genderFemale.isSelected = true
            UserUtils.setSex(Sex: "1")
            break
        case married:
            married.isSelected = true
            single.isSelected = false
            UserUtils.setMaritalStat(MaritalStat: "1")
            break
        case single:
            single.isSelected = true
            married.isSelected = false
            UserUtils.setMaritalStat(MaritalStat: "0")
            break
        case edc1:
            if edc1.isSelected {
                edc1.isSelected = false
                UserUtils.setEducation(Education: "")
            }else {
                selectSenderAndDeselectOther(selected: edc1, deselectedButtons: [edc2,edc3,edc4,edc5])
                UserUtils.setEducation(Education: "01")
            }
            break
        case edc2:
            if edc2.isSelected {
                edc2.isSelected = false
                UserUtils.setEducation(Education: "")
            }else {
                selectSenderAndDeselectOther(selected: edc2, deselectedButtons: [edc1,edc3,edc4,edc5])
                UserUtils.setEducation(Education: "02")
            }
            break
        case edc3:
            if edc3.isSelected {
                edc3.isSelected = false
                UserUtils.setEducation(Education: "")
            }else {
                selectSenderAndDeselectOther(selected: edc3, deselectedButtons: [edc1,edc2,edc4,edc5])
                UserUtils.setEducation(Education: "03")
            }
            break
        case edc4:
            if edc4.isSelected {
                edc4.isSelected = false
                UserUtils.setEducation(Education: "")
            }else {
                selectSenderAndDeselectOther(selected: edc4, deselectedButtons: [edc1,edc2,edc3,edc5])
                UserUtils.setEducation(Education: "04")
            }
            break
        case edc5:
            if edc5.isSelected {
                edc5.isSelected = false
                UserUtils.setEducation(Education: "")
            }else {
                selectSenderAndDeselectOther(selected: edc5, deselectedButtons: [edc1,edc2,edc3,edc4])
                UserUtils.setEducation(Education: "05")
            }
            break
        default: break
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
        countryTextField.inputView = picker
        cityTextField.inputView = picker
    }
    @IBAction func jobTextFieldAction(_ sender: HoshiTextField) {
        greenTextField(sender: jobTextField)
        if !jobs.isEmpty && dismissProblem{ // Sayfaya gidip geri gelince yine bu actiona giriyordu onu engellemek için dismissProblem değişkenini kulandım.
            dismissProblem = false
            let vc = storyboard?.instantiateViewController(withIdentifier: "SearchTableViewController") as! SearchTableViewController
            vc.items = jobs
            self.navigationController?.pushViewController(vc, animated: true)
        }else if jobs.isEmpty {
            let alert = UIAlertController(title: "Hata", message: "Sunucuya bağlanamadı.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Tamam", style: .cancel)
            let tryAction = UIAlertAction(title: "Tekrar Dene", style: .default) {
                (result : UIAlertAction) -> Void in
                self.getJobs()
            }
            alert.addAction(okAction)
            alert.addAction(tryAction)
            present(alert, animated: true, completion: nil)
        }else {
            dismissProblem = true
            view.endEditing(true)
        }
    }
    
    @IBAction func birthdayEditingDidEnd(_ sender: Any) {
        donedatePicker()
    }
    
    @IBAction func nameEditingDidEnd(_ sender: HoshiTextField) {
        if sender.text != "" {
            let fullName = nameTextField.text
            var fullNameArr = fullName?.split(separator: " ")
            switch fullNameArr?.count {
            case 1:
                UserUtils.setNameFirst(NameFirst: String(fullNameArr![0]))
                UserUtils.setNameLast(NameLast: "")
                break
            case 2:
                UserUtils.setNameFirst(NameFirst: String(fullNameArr![0]))
                UserUtils.setNameLast(NameLast: String(fullNameArr!.last!))
                break
            case 3:
                UserUtils.setNameFirst(NameFirst: String(fullNameArr![0]+" "+fullNameArr![1]))
                UserUtils.setNameLast(NameLast: String(fullNameArr!.last!))
                break
            default:break
            }
        }
    }
    @IBAction func companyNameDidEnd(_ sender: Any) {
        UserUtils.setCompany(Company: companyNameTextField.text!)
    }
    @IBAction func telNoDidEnd(_ sender: Any) {
        UserUtils.setMobileNo(MobileNo: telNoTextField.text!)
    }
    @IBAction func emailDidEnd(_ sender: Any) {
        UserUtils.setEmail(Email: emailTextField.text!)
    }
    
    @IBAction func pickerViewDidBegin(_ sender: HoshiTextField) {
        if sender == countryTextField || sender == cityTextField {
            if UserUtils.getCountry() == "" && !countryData.isEmpty && ViewController.firstTime {
                ViewController.firstTime = false
                picker.selectRow(1, inComponent: 0, animated: false)
                UserUtils.setCountry(Country: countryData[1].Key)
                UserUtils.setCountryName(CountryName: countryData[1].Value)
                self.countryTextField.text = countryData[1].Value
                greenTextField(sender: self.countryTextField)
                getCity(countryCode: countryData[1].Key)
            }
        }
        if countryData.isEmpty && sender != telNoTextField {
            let alert = UIAlertController(title: "Hata", message: "Sunucuya bağlanamadı.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Tamam", style: .cancel)
            let tryAction = UIAlertAction(title: "Tekrar Dene", style: .default) {
                (result : UIAlertAction) -> Void in
                self.getCountry()
            }
            alert.addAction(okAction)
            alert.addAction(tryAction)
            present(alert, animated: true, completion: nil)
        }
        switch sender {
        case telNoTextField:
            if (sender.text?.isEmpty)! {
                sender.text = "(5"
            }
            break
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
        default:
            break
        }
        
    }
    @IBAction func pickerViewDidEnd(_ sender: HoshiTextField) {
        cityDetailTextField.resignFirstResponder()
        self.setEditing(true, animated: true)
    }
    
    @IBAction func textFieldEditingChanged(_ sender: HoshiTextField) {
        switch sender {
        case telNoTextField:
            switch sender.text?.count {
            case 0:
                sender.text = "(5"
                ViewController.deleteTelNo = false
                break
            case 1:
                sender.text = "(5"
                ViewController.deleteTelNo = false
                break
            case 2:
                ViewController.deleteTelNo = false
                redTextField(sender: sender)
                break
            case 4:
                if ViewController.deleteTelNo == false {
                    sender.text?.append(")")
                    ViewController.deleteTelNo = true
                }else {
                    sender.text?.removeLast()
                    ViewController.deleteTelNo = false
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
        
        formatter.dateFormat = "yyyy-MM-dd"
        
        UserUtils.setBirthdate(Birthdate: birthdayTextField.text!)
        UserUtils.setFormatBirthdate(FormatBirthdate: formatter.string(from: datePicker.date))
        greenTextField(sender: birthdayTextField)
    }
    
    func selectSenderAndDeselectOther(selected: UIButton, deselectedButtons: [UIButton]){
        selected.isSelected = true
        for item in deselectedButtons {
            item.isSelected = false
        }
    }
    
    func deselectAll(deselectedButtons: [UIButton]){
        for item in deselectedButtons {
            item.isSelected = false
        }
    }
    
    func isEmail(mailText: String)->Bool{
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: mailText)
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
        return 2
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        switch component {
        case 0:
            return countryData.count
        case 1:
            return cityData.count
        default:
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        switch component {
        case 0:
            return countryData[row].Value
        case 1:
            return cityData[row].Value
        default:
            return ""
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch component {
        case 0:
            if row == 0 && !ViewController.firstTime {
                countryTextField.text = ""
                UserUtils.setCountry(Country: "")
                UserUtils.setCountryName(CountryName: "")
                ViewController.firstTime = true
                break
            }else {
                getCity(countryCode: countryData[row].Key)
                countryTextField.text = countryData[row].Value
                greenTextField(sender: countryTextField)
                UserUtils.setCountry(Country: countryData[row].Key)
                UserUtils.setCountryName(CountryName: countryData[row].Value)
            }
        case 1:
            if row == 0 {
                cityTextField.text = ""
                UserUtils.setRegion(Region: "")
                UserUtils.setRegionName(RegionName: "")
                break
            }
            cityTextField.text = cityData[row].Value
            greenTextField(sender: cityTextField)
            UserUtils.setRegion(Region: cityData[row].Key)
            UserUtils.setRegionName(RegionName: cityData[row].Value)
            break
        default:
            break
        }
    }
    
    @IBAction func addressEditingChanged(_ sender: HoshiTextField) {
        if sender.text != "" {
            self.greenTextField(sender: sender)
        }else {
            sender.borderInactiveColor = UIColor.black
        }
    }
    
    
    @IBAction func addressDidEnd(_ sender: HoshiTextField) {
        switch sender {
        case cityDetailTextField:
            UserUtils.setCity(City: sender.text ?? "")
            break
        case townTextField:
            UserUtils.setCityDetail(CityDetail: sender.text ?? "")
            break
        case townDetailTextField:
            UserUtils.setTown(Town: sender.text ?? "")
            break
        case streetTextField:
            UserUtils.setStreet(Street: sender.text ?? "")
            break
        case houseNumberTextField:
            UserUtils.setHouseNo(HouseNo: sender.text ?? "")
            break
        case postCodeTextField:
            UserUtils.setPostCode(PostCode: sender.text ?? "")
            break
        default:
            break
        }
    }
    
    
    @IBAction func nextAction(_ sender: UIButton) {
        if (nameTextField.text?.isEmpty)! {
            let alert = UIAlertController(title: "Uyarı", message: "Lütfen ad soyad giriniz.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Tamam", style: .cancel) {
                (result : UIAlertAction) -> Void in
                self.view.endEditing(true)
            }
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }else if (birthdayTextField.text?.isEmpty)! {
            let alert = UIAlertController(title: "Uyarı", message: "Lütfen doğum tarihi giriniz.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Tamam", style: .cancel) {
                (result : UIAlertAction) -> Void in
                self.view.endEditing(true)
            }
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }else if (datePicker.date.compare(Date()) == .orderedDescending ) {
            let alert = UIAlertController(title: "Uyarı", message: "Lütfen geçerli doğum tarihi giriniz.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Tamam", style: .cancel) {
                (result : UIAlertAction) -> Void in
                self.view.endEditing(true)
            }
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }else if ((telNoTextField.text?.count)! < 12) {
            let alert = UIAlertController(title: "Uyarı", message: "Lütfen telefon numarası giriniz.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Tamam", style: .cancel) {
                (result : UIAlertAction) -> Void in
                self.view.endEditing(true)
            }
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }else if (telNoTextField.text?[(telNoTextField.text?.startIndex)!] != "(" || telNoTextField.text![String.Index.init(encodedOffset: 4)] != ")") {
            let alert = UIAlertController(title: "Uyarı", message: "Lütfen telefon numarasını doğru formatta giriniz. Örnek Format: (5xx)xxxxxxx", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Tamam", style: .cancel) {
                (result : UIAlertAction) -> Void in
                self.view.endEditing(true)
            }
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }else if (emailTextField.text?.isEmpty)! {
            let alert = UIAlertController(title: "Uyarı", message: "Lütfen email giriniz.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Tamam", style: .cancel) {
                (result : UIAlertAction) -> Void in
                self.view.endEditing(true)
            }
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }else if (genderMale.isSelected == false && genderFemale.isSelected == false) {
            let alert = UIAlertController(title: "Uyarı", message: "Lütfen cinsiyet seçiniz.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Tamam", style: .cancel) {
                (result : UIAlertAction) -> Void in
                self.view.endEditing(true)
            }
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }else if (single.isSelected == false && married.isSelected == false) {
            let alert = UIAlertController(title: "Uyarı", message: "Lütfen medeni durum seçiniz.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Tamam", style: .cancel) {
                (result : UIAlertAction) -> Void in
                self.view.endEditing(true)
            }
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }else if !isEmail(mailText: emailTextField.text!){
            let alert = UIAlertController(title: "Uyarı", message: "Lütfen gerçerli email giriniz.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Tamam", style: .cancel) {
                (result : UIAlertAction) -> Void in
                self.view.endEditing(true)
            }
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }else if telNoTextField.text?.count != 12 {
            let alert = UIAlertController(title: "Uyarı", message: "Lütfen geçerli telefon numarası giriniz.", preferredStyle: .alert)
            let okAction = UIAlertAction(title: "Tamam", style: .cancel) {
                (result : UIAlertAction) -> Void in
                self.view.endEditing(true)
            }
            alert.addAction(okAction)
            present(alert, animated: true, completion: nil)
        }else {
            let vc = storyboard?.instantiateViewController(withIdentifier: "Step2ViewController") as! Step2ViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    @IBAction func clearAction(_ sender: UIButton) {
        let alert = UIAlertController(title: "Uyarı", message: "Doldurduğunuz bütün kısımlar silinecektir. Temizlemek istiyor musunuz?", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Temizle", style: .destructive){
            (result : UIAlertAction) -> Void in
            UserUtils.resetUser()
            self.reloadDataFromUserDefaults()
        }
        let cancelAction = UIAlertAction(title: "Vazgeç", style: .cancel)
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: true, completion: nil)
        
    }
}
