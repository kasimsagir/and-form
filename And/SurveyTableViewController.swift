//
//  SurveyTableViewController.swift
//  And
//
//  Created by kasım on 16.05.2018.
//  Copyright © 2018 Mobistech. All rights reserved.
//

import Foundation
import UIKit

class SurveyTableViewController : UITableViewController, UITextViewDelegate {
    
    @IBOutlet weak var footerView: UIView!
    
    static var poll : [ZCRM_MOBILE_FORM_WS_ZcrmSSurveyQuestWs] = []
    static var selectedChoices : [String] = []
    
    override func viewDidLoad() {
        getPollRequest()
        tableView.tableHeaderView = footerView
        tableView.tableFooterView = UIView()
        tableView.estimatedRowHeight = 400
    }
    
    func getPollRequest(){
        let client = ZCRM_MOBILE_FORM_WS(endpoint: "http://SSAGYCRMD01.anadolu.corp:8000/sap/bc/srt/rfc/sap/zcrm_mobile_form_ws/200/zcrm_mobile_form_ws/zcrm_mobile_form_ws")
        let request = client.request(ZCRM_MOBILE_FORM_WS_ZcrmGetSurveyDataWs())
        request.onComplete{
            (r) in
            print("\nTest: \(r)\n")
            if let pollResponse = r.value?.EtSurveyData.item {
                SurveyTableViewController.poll = pollResponse
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return SurveyTableViewController.poll.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let question = SurveyTableViewController.poll[indexPath.row]
        let choiseCount = question.Answers.item.count
        let answers = question.Answers.item
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionsTableViewCell", for: indexPath) as! QuestionsTableViewCell
        
        cell.lblQuestionText.text = question.QuestionText
        
        for subView in cell.stackView.subviews as [UIView] {
            subView.removeFromSuperview()
        }
        
        switch question.Type {
        case "SingleChoice":
            for i in 0 ..< choiseCount {
                let button = UIButton()
                
                let index = searchInSelectedChoices(id: answers[i].Id)
                
                if  index != -1 {
                    button.setImage(UIImage(named: "icon_radiobutton_checked"), for: .normal)
                }else {
                    button.setImage(UIImage(named: "icon_radiobutton_unchecked"), for: .normal)
                }
                
                button.contentHorizontalAlignment = .left
                button.setTitle(answers[i].Text, for: .normal)
                button.setTitleColor(UIColor.black, for: .normal)
                button.titleLabel?.textAlignment = .left
                button.heightAnchor.constraint(equalToConstant: 45.0).isActive = true
                
                button.tag = indexPath.section
                button.tag = indexPath.row*100+i
                button.addTarget(self, action: #selector(SurveyTableViewController.onRadioButtonAnswer(sender:)), for: UIControlEvents.touchUpInside)
                
                button.imageEdgeInsets.left = 5
                button.titleEdgeInsets.left = 10
                cell.stackView.addArrangedSubview(button)
            }
            break
        case "CHECKBOX":
            for i in 0 ..< choiseCount {
                let chechboxbutton = UIButton()
                let index = searchInSelectedChoices(id: answers[i].Id)
                
                if  index != -1 {
                    chechboxbutton.setImage(UIImage(named: "icon_checkbox_checked"), for: .normal)
                }else {
                    chechboxbutton.setImage(UIImage(named: "icon_checkbox_unchecked"), for: .normal)
                }
                
                chechboxbutton.contentHorizontalAlignment = .left
                chechboxbutton.setTitle(answers[i].Text, for: .normal)
                chechboxbutton.setTitleColor(UIColor.black, for: .normal)
                chechboxbutton.titleLabel?.textAlignment = .left
                chechboxbutton.heightAnchor.constraint(equalToConstant: 45.0).isActive = true
                
                chechboxbutton.tag = indexPath.section
                chechboxbutton.tag = indexPath.row*100+i
                chechboxbutton.addTarget(self, action: #selector(SurveyTableViewController.onAnswer(sender:)), for: UIControlEvents.touchUpInside)
                
                chechboxbutton.imageEdgeInsets.left = 5
                chechboxbutton.titleEdgeInsets.left = 10
                cell.stackView.addArrangedSubview(chechboxbutton)
            }
            break
        case "Text":
            
            let textView = UITextView()
            textView.layer.borderColor = UIColor.darkGray.cgColor
            textView.layer.borderWidth = 1
            textView.layer.cornerRadius = 3
            textView.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
            textView.text = answers[0].Text
            textView.textAlignment = .left
            textView.backgroundColor = UIColor.white
            textView.tag = indexPath.row
            textView.delegate = self
            textView.font = UIFont(name: "SystemFont", size: 15.0)
            
            cell.stackView.addArrangedSubview(textView)
            
            break
        default: break
            
        }
        
        return cell
    }
    
    @objc func onAnswer(sender: UIButton){
        let choiceId = SurveyTableViewController.poll[sender.tag/100].Answers.item[sender.tag%100].Id
        let index = searchInSelectedChoices(id: choiceId)
        if index == -1 {
            SurveyTableViewController.selectedChoices.append(choiceId)
        }else {
            SurveyTableViewController.selectedChoices.remove(at: index)
        }
        self.tableView.reloadData()
        /*
         let question = sender.tag/100
         let index = searhcInSelectedChoices(questionId: question, searchedChoiceId: poll[question].Answers[sender.tag % 100].Id)
         if index == -1 {
         let choiceId = Id()
         choiceId.id = poll.questions![question].choices![sender.tag % 100].id
         self.answers[question].selectedChoices.append(choiceId)
         }else {
         self.answers[question].selectedChoices.remove(at: index)
         }
         self.tableView.reloadData()*/
    }
    
    @objc func onRadioButtonAnswer(sender: UIButton){
        let choiceId = SurveyTableViewController.poll[sender.tag/100].Answers.item[sender.tag%100].Id
        let index = searchInSelectedChoices(id: choiceId)
        if index == -1 {
            let choiceIndex = searchRadioInSelectedChoices(questionId: sender.tag/100)
            if choiceIndex != -1 {
                SurveyTableViewController.selectedChoices.remove(at: choiceIndex)
            }
            SurveyTableViewController.selectedChoices.append(choiceId)
        }else {
            SurveyTableViewController.selectedChoices.remove(at: index)
        }
        self.tableView.reloadData()
        // self.tableView.reloadRows(at: [IndexPath(row: sender.tag/100, section: 0)], with: .automatic)
        /*
         let question = sender.tag/100
         let index = searhcInSelectedChoices(questionId: question, searchedChoiceId: sender.tag % 100)
         if index == -1 {
         let choiceId = Id()
         choiceId.id = poll.questions![question].choices![sender.tag % 100].id
         self.answers[question].selectedChoices.removeAll()
         self.answers[question].selectedChoices.append(choiceId)
         }else {
         self.answers[question].selectedChoices.remove(at: index)
         }
         self.tableView.reloadData()*/
    }
    
    func textViewDidChange(_ textView: UITextView) {
        let choiceId = SurveyTableViewController.poll[textView.tag].Answers.item[0].Id
        SurveyTableViewController.poll[textView.tag].Answers.item[0].Text = textView.text
        let index = searchInSelectedChoices(id: choiceId)
        if textView.text.isEmpty {
            SurveyTableViewController.selectedChoices.remove(at: index)
        }else if index == -1 {
            SurveyTableViewController.selectedChoices.append(choiceId)
        }
        
    }
    
    func searchInSelectedChoices(id: String)->Int{
        for item in SurveyTableViewController.selectedChoices {
            if item == id {
                return SurveyTableViewController.selectedChoices.index(of: item)!
            }
        }
        return -1
    }
    
    func searchRadioInSelectedChoices(questionId: Int)->Int{
        let answers = SurveyTableViewController.poll[questionId].Answers.item
        for item in answers {
            let index = searchInSelectedChoices(id: item.Id)
            if index != -1 {
                return index
            }
        }
        return -1
    }
    /*
     func searhcInSelectedChoices(questionId: Int, searchedChoiceId: String)->Int{
     for item in answers[questionId].selectedChoices {
     if item.id == searchedChoiceId {
     return answers[questionId].selectedChoices.index(of: item)!
     }
     }
     return -1
     }*/
    
    
}
