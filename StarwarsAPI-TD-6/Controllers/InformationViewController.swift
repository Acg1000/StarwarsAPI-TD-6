//
//  InformationViewController.swift
//  StarwarsAPI-TD-6
//
//  Created by Andrew Graves on 9/13/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController, UITableViewDataSource, UIPickerViewDelegate , UIPickerViewDataSource {
    
    var character: Character = {
        return Character(name: "", birthYear: "", eyeColor: "", hairColor: "", height: 0, homeworld: "https://google.com" , url: "https://google.com")
    }()
    
    var characters: [Character] = [] {
        didSet {
            picker.dataSource = self
            
        }
    }
    
    var planet: Planet = {
        return Planet(name: "")
    }()

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var smallestLabel: UILabel!
    @IBOutlet weak var largestLabel: UILabel!
    @IBOutlet weak var informationTableView: UITableView!
    
    
    let client = StarwarsAPIClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        informationTableView.dataSource = self
        informationTableView.reloadData()
        
        picker.delegate = self
        picker.dataSource = self
        
        
    }
    

    // ==========================================
    // MARK: Data Source for the TableView
    // ==========================================
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let normalAttributeCell = tableView.dequeueReusableCell(withIdentifier: NormalTableViewCell.reuseIdentifier, for: indexPath) as! NormalTableViewCell
        let convertableAttributeCell = tableView.dequeueReusableCell(withIdentifier: ConvertableUnitTableViewCell.reuseIdentifer, for: indexPath) as! ConvertableUnitTableViewCell
        
        switch indexPath.row {
        case 0:
            let viewModel = NormalCellViewModel(title: "Born", item: character.birthYear)
            normalAttributeCell.configure(with: viewModel)
            
            return normalAttributeCell
            
        case 1:
            let viewModel = NormalCellViewModel(title: "Home", item: planet.name)
            normalAttributeCell.configure(with: viewModel)
            
            return normalAttributeCell
            
        case 2:
            let viewModel = ConvertableCellViewModel(title: "Height", item: character.height, convertedItem: 0)
            convertableAttributeCell.configure(viewModel: viewModel)
            
            return convertableAttributeCell
            
        case 3:
            let viewModel = NormalCellViewModel(title: "Eyes", item: character.eyeColor)
            normalAttributeCell.configure(with: viewModel)
            
            return normalAttributeCell
            
        case 4:
            let viewModel = NormalCellViewModel(title: "Hair", item: character.hairColor)
            normalAttributeCell.configure(with: viewModel)
            
            return normalAttributeCell
            
        default:
            fatalError()
        }
    }
    
    func setBiggest() {
        var biggest = characters[0]
        
        for character in characters {
            if character.height > biggest.height {
                biggest = character
            }
        }
        
        largestLabel.text = biggest.name
    }
        
    func setSmallest() {
        var smallest = characters[0]
        
        for character in characters {
            if character.height < smallest.height {
                smallest = character
            }
        }
        
        smallestLabel.text = smallest.name
    }
    
    
    // ==========================================
    // MARK: Data Source for the Picker
    // ==========================================
    
    
    
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return characters.count
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return characters[row].name
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Current Row: \(row)")
        titleLabel.text = characters[row].name
        character = characters[row]
        
        client.lookupPlanet(withURL: characters[row].homeworld) { planet, error in
            self.planet = planet
        }
        
        informationTableView.reloadData()
        
    }
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
