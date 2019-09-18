//
//  PersonDataSource.swift
//  StarwarsAPI-TD-6
//
//  Created by Andrew Graves on 9/12/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//

import Foundation
import UIKit

class PersonDataSource: NSObject, UITableViewDataSource {
    private var person: Person
    let tableView: UITableView

    init(person: Person, tableView: UITableView) {
        print("called init method")
        
        self.person = person
        self.tableView = tableView
        super.init()
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("Called number of rows in section")
        return 5
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        print("called cell for row at")
        print("current indexPath row = \(indexPath.row)")
        
        let normalAttributeCell = tableView.dequeueReusableCell(withIdentifier: NormalTableViewCell.reuseIdentifier, for: indexPath) as! NormalTableViewCell
        let convertableAttributeCell = tableView.dequeueReusableCell(withIdentifier: ConvertableUnitTableViewCell.reuseIdentifer, for: indexPath) as! ConvertableUnitTableViewCell

        switch indexPath.row {
        case 0:
            let viewModel = NormalCellViewModel(title: "Born", item: person.birthYear)
            normalAttributeCell.configure(with: viewModel)
            
            return normalAttributeCell
            
        case 1:
            let viewModel = NormalCellViewModel(title: "Home", item: "TBD")
            normalAttributeCell.configure(with: viewModel)
            
            return normalAttributeCell
            
        case 2:
            let viewModel = ConvertableCellViewModel(title: "Height", item: person.height, convertedItem: 0)
            convertableAttributeCell.configure(viewModel: viewModel)
            
            return convertableAttributeCell
            
        case 3:
            let viewModel = NormalCellViewModel(title: "Eyes", item: person.eyeColor)
            normalAttributeCell.configure(with: viewModel)
            
            return normalAttributeCell
            
        case 4:
            let viewModel = NormalCellViewModel(title: "Hair", item: person.hairColor)
            normalAttributeCell.configure(with: viewModel)
            
            return normalAttributeCell
            
        default:
            fatalError()
        }
    }
}

extension PersonDataSource {
    func update(with person: Person) {
        self.person = person
    }
}
