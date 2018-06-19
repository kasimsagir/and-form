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
    @IBOutlet weak var project3Button: UIButton!
    @IBOutlet weak var payType1: UIButton!
    @IBOutlet weak var payType2: UIButton!
    @IBOutlet weak var payType3: UIButton!
    @IBOutlet weak var purposeType1: UIButton!  //OTURMA
    @IBOutlet weak var purposeType2: UIButton! // YATIRIM
    @IBOutlet weak var apartmentType1: UIButton!
    @IBOutlet weak var apartmentType2: UIButton!
    @IBOutlet weak var apartmentType3: UIButton!
    @IBOutlet weak var apartmentType4: UIButton!
    @IBOutlet weak var apartmentType5: UIButton!
    
    
    override func viewDidAppear(_ animated: Bool) {
        reloadDataFromUserDefaults()
    }
    
    func reloadDataFromUserDefaults() {
        switch UserUtils.getProject() {
        case "PASTEL":
            project1Button.isSelected = true
            project2Button.isSelected = false
            project3Button.isSelected = false
            break
        case "FREKANS":
            project1Button.isSelected = false
            project2Button.isSelected = true
            project3Button.isSelected = false
            break
        case "BEYAZESYA":
            project1Button.isSelected = false
            project2Button.isSelected = false
            project3Button.isSelected = true
            break
        default:
            project1Button.isSelected = false
            project2Button.isSelected = false
            break
        }
        switch UserUtils.getPayType() {
        case "0":
            payType1.isSelected = true
            break
        case "1":
            payType2.isSelected = true
            break
        case "2":
            payType3.isSelected = true
            break
        default:
            payType1.isSelected = false
            payType2.isSelected = false
            payType3.isSelected = false
            break
        }
        switch UserUtils.getPurposeType() {
        case "1":
            purposeType1.isSelected = false
            purposeType2.isSelected = true
            break
        case "2":
            purposeType1.isSelected = true
            purposeType2.isSelected = false
            break
        case "3":
            purposeType1.isSelected = true
            purposeType2.isSelected = true
            break
        default:
            purposeType1.isSelected = false
            purposeType2.isSelected = false
            break
        }
        if UserUtils.getApartmentType1() == "X" {
            apartmentType1.isSelected = true
        }else {
            apartmentType1.isSelected = false
        }
        if UserUtils.getApartmentType2() == "X" {
            apartmentType2.isSelected = true
        }else {
            apartmentType2.isSelected = false
        }
        if UserUtils.getApartmentType3() == "X" {
            apartmentType3.isSelected = true
        }else {
            apartmentType3.isSelected = false
        }
        if UserUtils.getApartmentType4() == "X" {
            apartmentType4.isSelected = true
        }else {
            apartmentType4.isSelected = false
        }
    }
    
    @IBAction func buttonAction(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
            if sender == apartmentType1 {
                UserUtils.setApartmentType1(ApartmentType1: "")
            }else if sender == apartmentType2 {
                UserUtils.setApartmentType2(ApartmentType2: "")
            }else if sender == apartmentType3 {
                UserUtils.setApartmentType3(ApartmentType3: "")
            }else if sender == apartmentType4 {
                UserUtils.setApartmentType4(ApartmentType4: "")
            }else if sender == purposeType1 {   // OTURMA
                if purposeType2.isSelected {    // YATIRIM
                    UserUtils.setPurposeType(PurposeType: "1")
                }else {
                    UserUtils.setPurposeType(PurposeType: "")
                }
            }else if sender == purposeType2 {
                if purposeType1.isSelected {
                    UserUtils.setPurposeType(PurposeType: "2")
                }else {
                    UserUtils.setPurposeType(PurposeType: "")
                }
            }
        }else {
            sender.isSelected = true
            if sender == apartmentType1 {
                UserUtils.setApartmentType1(ApartmentType1: "X")
            }else if sender == apartmentType2 {
                UserUtils.setApartmentType2(ApartmentType2: "X")
            }else if sender == apartmentType3 {
                UserUtils.setApartmentType3(ApartmentType3: "X")
            }else if sender == apartmentType4 {
                UserUtils.setApartmentType4(ApartmentType4: "X")
            }else if sender == purposeType1 {
                if purposeType2.isSelected {
                    UserUtils.setPurposeType(PurposeType: "3")
                }else {
                    UserUtils.setPurposeType(PurposeType: "2")
                }
            }else if sender == purposeType2 {
                if purposeType1.isSelected {
                    UserUtils.setPurposeType(PurposeType: "3")
                }else {
                    UserUtils.setPurposeType(PurposeType: "1")
                }
            }
        }
    }
    
    @IBAction func dismissView(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func buttonSelected(_ sender: UIButton) {
        switch sender {
        case project1Button:
            if project1Button.isSelected {
                project1Button.isSelected = false
                UserUtils.setProject(Project: "")
                break
            }
            project1Button.isSelected = true
            project2Button.isSelected = false
            project3Button.isSelected = false
            UserUtils.setProject(Project: "PASTEL")
            break
        case project2Button:
            if project2Button.isSelected {
                project2Button.isSelected = false
                UserUtils.setProject(Project: "")
                break
            }
            project1Button.isSelected = false
            project2Button.isSelected = true
            project3Button.isSelected = false
            UserUtils.setProject(Project: "FREKANS")
            break
        case project3Button:
            if project3Button.isSelected {
                project3Button.isSelected = false
                UserUtils.setProject(Project: "")
                break
            }
            project1Button.isSelected = false
            project2Button.isSelected = false
            project3Button.isSelected = true
            UserUtils.setProject(Project: "BEYAZESYA")
            break
        case payType1:
            if payType1.isSelected {
                payType1.isSelected = false
                UserUtils.setPayType(PayType: "")
                break
            }
            payType1.isSelected = true
            payType2.isSelected = false
            payType3.isSelected = false
            UserUtils.setPayType(PayType: "0")
            break
        case payType2:
            if payType2.isSelected {
                payType2.isSelected = false
                UserUtils.setPayType(PayType: "")
                break
            }
            payType1.isSelected = false
            payType2.isSelected = true
            payType3.isSelected = false
            UserUtils.setPayType(PayType: "1")
            break
        case payType3:
            if payType3.isSelected {
                payType3.isSelected = false
                UserUtils.setPayType(PayType: "")
                break
            }
            payType1.isSelected = false
            payType2.isSelected = false
            payType3.isSelected = true
            UserUtils.setPayType(PayType: "2")
            break
        default:
            break
        }
    }
}
