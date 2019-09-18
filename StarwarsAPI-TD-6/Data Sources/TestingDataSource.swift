//
//  PersonDataSource.swift
//  StarwarsAPI-TD-6
//
//  Created by Andrew Graves on 9/12/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//

import Foundation
import UIKit

class TestingDataSource: NSObject, UITableViewDataSource, UITableViewDelegate {
    let contacts:[[String]] = [
    ["Elon Musk",       "+1-201-3141-5926"],
    ["Bill Gates",      "+1-202-5358-9793"],
    ["Tim Cook",        "+1-203-2384-6264"],
    ["Richard Branson", "+1-204-3383-2795"],
    ["Jeff Bezos",      "+1-205-0288-4197"],
    ["Warren Buffet",   "+1-206-1693-9937"],
    ["The Zuck",        "+1-207-5105-8209"],
    ["Carlos Slim",     "+1-208-7494-4592"],
    ["Bill Gates",      "+1-209-3078-1640"],
    ["Larry Page",      "+1-210-6286-2089"],
    ["Harold Finch",    "+1-211-9862-8034"],
    ["Sergey Brin",     "+1-212-8253-4211"],
    ["Jack Ma",         "+1-213-7067-9821"],
    ["Steve Ballmer",   "+1-214-4808-6513"],
    ["Phil Knight",     "+1-215-2823-0664"],
    ["Paul Allen",      "+1-216-7093-8446"],
    ["Woz",             "+1-217-0955-0582"]
    ]
    let tableView = UITableView()
    
    override init() {
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("CALLED NUMBER OF ROWS")
        print(tableView)
        print(contacts.count)
        
        return contacts.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        print("CALLED NUMBER OF SECTIONS")
        print(tableView)
        
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("called cell for row at")
        print("current indexPath row = \(indexPath.row)")
        
        let normalAttributeCell = tableView.dequeueReusableCell(withIdentifier: NormalTableViewCell.reuseIdentifier, for: indexPath) as! NormalTableViewCell
        
        normalAttributeCell.titleLabel.text = contacts[indexPath.row][0]
        normalAttributeCell.itemLabel.text = contacts[indexPath.row][1]
        
        return normalAttributeCell
        
    }
}
