//
//  InformedTypeDetailTableViewController.swift
//  And
//
//  Created by Kasım on 25.06.2018.
//  Copyright © 2018 Mobistech. All rights reserved.
//

import Foundation
import UIKit
import PKHUD

class InformedTypeDetailTableViewController: UITableViewController, UISearchBarDelegate {
    var informedDetailTypes : [ZCRM_MOBILE_FORM_WS_BspWdDropdownLine] = []
    
    var filteredItems : [ZCRM_MOBILE_FORM_WS_BspWdDropdownLine] = []
    
    
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = false
        self.title = UserUtils.getInformedTypeValue()
        getInformedTypesDetail(informedType: UserUtils.getInformedType())
    }
    
    func getInformedTypesDetail(informedType: String){
        PKHUD.sharedHUD.show()
        let client = ZCRM_MOBILE_FORM_WS(endpoint: "http://SSAGYCRMD01.anadolu.corp:8000/sap/bc/srt/rfc/sap/zcrm_mobile_form_ws/200/zcrm_mobile_form_ws/zcrm_mobile_form_ws")
        let request = client.request(ZCRM_MOBILE_FORM_WS_ZcrmGetFieldShWs(IvAnaKaynak: informedType, IvCountry: "", IvFieldname: "kaynak", IvRegion: ""))
        request.onComplete{
            (r) in
            PKHUD.sharedHUD.hide()
            if let informedTypeResponse = r.value?.EtValues.item {
                self.informedDetailTypes = informedTypeResponse
                self.filteredItems = informedTypeResponse
                self.tableView.reloadData()
            }else {
                let alert = UIAlertController(title: "Hata", message: "Sunucuya bağlanamadı.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Tamam", style: .cancel)
                let tryAction = UIAlertAction(title: "Tekrar Dene", style: .default) {
                    (result : UIAlertAction) -> Void in
                    self.getInformedTypesDetail(informedType: informedType)
                }
                alert.addAction(okAction)
                alert.addAction(tryAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            filteredItems = informedDetailTypes
        }else {
            filterContentForSearchText(searchBar.text!)
        }
        tableView.reloadData()
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredItems = informedDetailTypes.filter({( item : ZCRM_MOBILE_FORM_WS_BspWdDropdownLine) -> Bool in
            return item.Value.lowercased().contains(searchText.lowercased())
        })
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = filteredItems[indexPath.row].Value
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserUtils.setInformedTypeDetail(InformedTypeDetail: filteredItems[indexPath.row].Key)
        UserUtils.setInformedTypeDetailValue(InformedTypeDetailValue: filteredItems[indexPath.row].Value)
        let controllers = self.navigationController?.viewControllers
        for vc in controllers! {
            if vc is Step3ViewController {
                self.navigationController?.popToViewController(vc as! Step3ViewController, animated: true)
            }
        }
    }
}
