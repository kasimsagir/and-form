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
    
    var poll = Poll()
    var answers : [AnswerRequestModel] = []
    
    override func viewDidLoad() {
        initPoll()
        tableView.tableHeaderView = footerView
        tableView.tableFooterView = UIView()
    }
    
    func initPoll(){
        poll.id = 1
        poll.date = Date().timeIntervalSince1970
        poll.pollType = "GENERAL"
        poll.title = "Title"
        poll.sessionName = "Session"
        
        var pq = [PollQuestion]()
        let pq1 = PollQuestion()
        pq1.id = 1
        pq1.questionText = "Uygulamamızı beğendiniz mi?"
        pq1.choiceType = "RADIO"
        pq1.choices = []
        
        let choice = PollQuestionChoice()
        choice.id = 2
        choice.text = "Evet"
        pq1.choices?.append(choice)
        
        let choice2 = PollQuestionChoice()
        choice2.id = 3
        choice2.text = "Hayır"
        pq1.choices?.append(choice2)
        
        let pq2 = PollQuestion()
        pq2.id = 2
        pq2.questionText = "Hangi kısmını/kısımlarını beğendiniz?"
        pq2.choiceType = "CHECKBOX"
        pq2.choices = []
        
        let choice3 = PollQuestionChoice()
        choice3.id = 4
        choice3.text = "Form Doldurma"
        pq2.choices?.append(choice3)
        
        let choice4 = PollQuestionChoice()
        choice4.id = 5
        choice4.text = "Anket"
        pq2.choices?.append(choice4)
        
        let pq3 = PollQuestion()
        pq3.id = 1
        pq3.questionText = "Lütfen görüş ve önerilerinizi giriniz."
        pq3.choiceType = "FREE_TEXT"
        pq3.choices = []
        
        
        pq.append(pq1)
        pq.append(pq2)
        pq.append(pq1)
        pq.append(pq2)
        pq.append(pq1)
        pq.append(pq2)
        pq.append(pq3)
        poll.questions = pq
        initAnswers()
        self.tableView.reloadData()
    }
    
    func initAnswers(){
        // CREATE ANSWERS
        var temp : AnswerRequestModel?
        for question in poll.questions! {
            temp = AnswerRequestModel()
            temp!.question.id = question.id
            temp!.freeText = ""
            temp!.selectedChoices = []
            answers.append(temp!)
        }
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if poll.questions == nil {
            return 0
        }
        return poll.questions!.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
  
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let question = poll.questions![indexPath.row]
        let choiseCount: Int = (question.choices?.count)!
        let answer = answers[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "QuestionsTableViewCell", for: indexPath) as! QuestionsTableViewCell
        
        cell.lblQuestionText.text = question.questionText
        
        for subView in cell.stackView.subviews as [UIView] {
            subView.removeFromSuperview()
        }
        
        switch question.choiceType! {
        case "RADIO":
            for i in 0 ..< choiseCount {
                let button = UIButton()
                let index = searhcInSelectedChoices(questionId: (indexPath.row), searchedChoiceId: question.choices![i].id!)
                if  index != -1 {
                    button.setImage(UIImage(named: "icon_radiobutton_checked"), for: .normal)
                }else {
                    button.setImage(UIImage(named: "icon_radiobutton_unchecked"), for: .normal)
                }
                button.contentHorizontalAlignment = .left
                button.setTitle(question.choices![i].text, for: .normal)
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
                let index = searhcInSelectedChoices(questionId: (indexPath.row), searchedChoiceId: question.choices![i].id!)
                if index != -1 {
                    chechboxbutton.setImage(UIImage(named: "icon_checkbox_checked"), for: .normal)
                }else {
                    chechboxbutton.setImage(UIImage(named: "icon_checkbox_unchecked"), for: .normal)
                }
                chechboxbutton.contentHorizontalAlignment = .left
                chechboxbutton.setTitle(question.choices![i].text, for: .normal)
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
        case "FREE_TEXT":
            cell.backgroundColor = UIColor.white
            
            let textView = UITextView()
            textView.layer.borderColor = UIColor.darkGray.cgColor
            textView.layer.borderWidth = 1
            textView.layer.cornerRadius = 3
            textView.heightAnchor.constraint(equalToConstant: 30.0).isActive = true
            textView.text  = answer.freeText
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
        let question = sender.tag/100
        let index = searhcInSelectedChoices(questionId: question, searchedChoiceId: poll.questions![question].choices![sender.tag % 100].id!)
        if index == -1 {
            let choiceId = Id()
            choiceId.id = poll.questions![question].choices![sender.tag % 100].id
            self.answers[question].selectedChoices.append(choiceId)
        }else {
            self.answers[question].selectedChoices.remove(at: index)
        }
        self.tableView.reloadData()
    }
    
    @objc func onRadioButtonAnswer(sender: UIButton){
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
        self.tableView.reloadData()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        answers[textView.tag].freeText = textView.text
    }
    
    func searhcInSelectedChoices(questionId: Int, searchedChoiceId: Int)->Int{
        for item in answers[questionId].selectedChoices {
            if item.id == searchedChoiceId {
                return answers[questionId].selectedChoices.index(of: item)!
            }
        }
        return -1
    }
    

}
