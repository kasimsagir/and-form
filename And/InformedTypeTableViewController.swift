//
//  InformedTypeTableViewController.swift
//  And
//
//  Created by Kasım on 23.06.2018.
//  Copyright © 2018 Mobistech. All rights reserved.
//

import Foundation
import UIKit

class InformedTypeTableViewController: UITableViewController, UISearchBarDelegate {
    
    var informedTypes = ["İnternet", "Havadan"]
    var filteredItems : [String] = []
    
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = false
        filteredItems = informedTypes
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
        filteredItems = informedTypes.filter({( item : String) -> Bool in
            return item.lowercased().contains(searchText.lowercased())
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
        cell.textLabel?.text = filteredItems[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        UserUtils.setInformedType(InformedType: filteredItems[indexPath.row])
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "InformedTypeDetailTableViewController") as! InformedTypeDetailTableViewController
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
