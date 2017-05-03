//
//  ItemTableViewController.swift
//  TaxCalculator
//
//  Created by Aqeel Kamadia on 2017-03-24.
//  Copyright © 2017 Aqeel Kamadia. All rights reserved.
//

import UIKit

class ItemTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Constants.sharedInstance.items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ItemTableViewCell = tableView.dequeueReusableCell(withIdentifier: "itemTableViewCell") as! ItemTableViewCell
        cell.itemLabel.text = Constants.sharedInstance.items[indexPath.row]
        cell.costLabel.text = Constants.sharedInstance.costs[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == UITableViewCellEditingStyle.delete {
            Constants.sharedInstance.items.remove(at: indexPath.row)
            Constants.sharedInstance.costs.remove(at: indexPath.row)
            tableView.reloadData()
        }
    }
    
}
