//
//  SearchTableViewController.swift
//  And
//
//  Created by kasım on 2.06.2018.
//  Copyright © 2018 Mobistech. All rights reserved.
//

import Foundation
import UIKit

class SearchTableViewController: UITableViewController, UISearchBarDelegate {
    
    var items : [ZCRM_MOBILE_FORM_WS_ZcrmSJobSh] = []
    var filteredItems : [ZCRM_MOBILE_FORM_WS_ZcrmSJobSh] = []
    
    override func viewDidLoad() {
        filteredItems = items
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            filteredItems = items
        }else {
            filterContentForSearchText(searchBar.text!)
        }
        tableView.reloadData()
    }
    
    func filterContentForSearchText(_ searchText: String, scope: String = "All") {
        filteredItems = items.filter({( item : ZCRM_MOBILE_FORM_WS_ZcrmSJobSh) -> Bool in
            return item.ValueDescr.lowercased().contains(searchText.lowercased())
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
        cell.textLabel?.text = filteredItems[indexPath.row].ValueDescr
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserUtils.setJob(Job: filteredItems[indexPath.row].Value)
        UserUtils.setJobDescription(JobDescription: filteredItems[indexPath.row].ValueDescr)
        self.navigationController?.popViewController(animated: true)
    }
    
}
