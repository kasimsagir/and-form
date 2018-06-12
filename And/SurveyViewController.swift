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
            self.postAnswers()
        }
        alert.addAction(okAction)
        present(alert, animated: true, completion: nil)
    }
    
    func getPostData()->ZCRM_MOBILE_FORM_WS_ZcrmCreateSurveyWs{
        var poll = SurveyTableViewController.poll
        let selectedChoices = SurveyTableViewController.selectedChoices
        for item in poll {
            let answerIndex = poll.index(where: {$0.AnswerId == item.AnswerId})
            for question in item.Answers.item {
                if !findIdInArray(choice: question.Id, array: selectedChoices) {
                    let choiceIndex = poll[answerIndex!].Answers.item.index(where: {$0.Id == question.Id})
                    poll[answerIndex!].Answers.item.remove(at: choiceIndex!)
                }
            }
        }
        print(poll)
        let postData = ZCRM_MOBILE_FORM_WS_ZcrmCreateSurveyWs(IsSurveyData: ZCRM_MOBILE_FORM_WS_ZcrmSSurveyCreateWs(ObjectId: UserUtils.getObjectId(), Questions: ZCRM_MOBILE_FORM_WS_ZcrmTtSurveyQuestWs(item: poll)))
        return postData
    }
    
    func postAnswers(){
        let client = ZCRM_MOBILE_FORM_WS(endpoint: "http://SSAGYCRMD01.anadolu.corp:8000/sap/bc/srt/rfc/sap/zcrm_mobile_form_ws/200/zcrm_mobile_form_ws/zcrm_mobile_form_ws")
        let request = client.request(getPostData())
        request.onComplete{
            (r) in
            print("\nTest: \(r.value.debugDescription)\n")
            UserUtils.resetUser()
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "startPage")
            self.present(vc!, animated: true, completion: nil)
        }
    }
    
    func findIdInArray(choice: String, array: [String])->Bool{
        for item in array {
            if choice == item {
                return true
            }
        }
        return false
    }
}

