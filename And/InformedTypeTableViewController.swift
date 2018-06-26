//
//  InformedTypeTableViewController.swift
//  And
//
//  Created by Kasım on 23.06.2018.
//  Copyright © 2018 Mobistech. All rights reserved.
//

import Foundation
import UIKit
import PKHUD

class InformedTypeTableViewController: UITableViewController, UISearchBarDelegate {
    
    var informedTypes : [ZCRM_MOBILE_FORM_WS_BspWdDropdownLine] = []
    var filteredItems : [ZCRM_MOBILE_FORM_WS_BspWdDropdownLine] = []
    
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = false
        getInformedTypes()
    }
    
    func getInformedTypes(){
        PKHUD.sharedHUD.show()
        let client = ZCRM_MOBILE_FORM_WS(endpoint: "http://SSAGYCRMD01.anadolu.corp:8000/sap/bc/srt/rfc/sap/zcrm_mobile_form_ws/200/zcrm_mobile_form_ws/zcrm_mobile_form_ws")
        let request = client.request(ZCRM_MOBILE_FORM_WS_ZcrmGetFieldShWs(IvAnaKaynak: "", IvCountry: "", IvFieldname: "ana_kaynak", IvRegion: ""))
        request.onComplete{
            (r) in
            PKHUD.sharedHUD.hide()
            if let informedTypeResponse = r.value?.EtValues.item {
                self.informedTypes = informedTypeResponse
                self.filteredItems = informedTypeResponse
                self.tableView.reloadData()
            }else {
                let alert = UIAlertController(title: "Hata", message: "Sunucuya bağlanamadı.", preferredStyle: .alert)
                let okAction = UIAlertAction(title: "Tamam", style: .cancel)
                let tryAction = UIAlertAction(title: "Tekrar Dene", style: .default) {
                    (result : UIAlertAction) -> Void in
                    self.getInformedTypes()
                }
                alert.addAction(okAction)
                alert.addAction(tryAction)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            filteredItems = informedTypes
        }else {
            filterContentForSearchText(searchBar.text!)
        }
        tableView.reloadData()
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredItems = informedTypes.filter({( item : ZCRM_MOBILE_FORM_WS_BspWdDropdownLine) -> Bool in
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
        UserUtils.setInformedType(InformedType: filteredItems[indexPath.row].Key)
        UserUtils.setInformedTypeValue(InformedTypeValue: filteredItems[indexPath.row].Value)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "InformedTypeDetailTableViewController") as! InformedTypeDetailTableViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
