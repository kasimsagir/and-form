//
//  InformedTypeDetailTableViewController.swift
//  And
//
//  Created by Kasım on 25.06.2018.
//  Copyright © 2018 Mobistech. All rights reserved.
//

import Foundation
import UIKit

class InformedTypeDetailTableViewController: UITableViewController, UISearchBarDelegate {
    var informedDetailTypes = ["google", "haber siteleri"]
    
    var filteredItems : [String] = []
    
    
    override func viewDidLoad() {
        self.navigationController?.isNavigationBarHidden = false
        filteredItems = informedDetailTypes
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
        filteredItems = informedDetailTypes.filter({( item : String) -> Bool in
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
        UserUtils.setInformedTypeDetail(InformedTypeDetail: filteredItems[indexPath.row])
        //let vc = self.storyboard?.instantiateViewController(withIdentifier: "Step3ViewController") as! Step3ViewController
        //self.navigationController?.popToViewController(Step3ViewController.self, animated: true)
        //self.navigationController?.pushViewController(vc, animated: true)
        
        let controllers = self.navigationController?.viewControllers
        for vc in controllers! {
            if vc is Step3ViewController {
                self.navigationController?.popToViewController(vc as! Step3ViewController, animated: true)
            }
        }
    }
}
