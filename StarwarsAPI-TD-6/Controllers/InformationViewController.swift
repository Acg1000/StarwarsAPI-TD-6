//
//  InformationViewController.swift
//  StarwarsAPI-TD-6
//
//  Created by Andrew Graves on 9/13/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController, UITableViewDataSource, UIPickerViewDelegate , UIPickerViewDataSource {
    
    // ==========================================
    // MARK: Current Vars
    // ==========================================
    
    // character varable stores the character currently on display
    lazy var currentObject: Object = {
        return Character(name: "", birthYear: "", eyeColor: "", hairColor: "", height: 0, homeworld: "", url: "")
    }()
    
    
    // The homeplanet of the current character
    var planet: Planet = {
        return Planet(name: "")
    }()
    
    
    // Stores all of the characters that exist from the API
    var currentObjects: [Object] = [] {
        didSet {
            picker.dataSource = self
            
        }
    }
    
    var navigationTitle: String = ""
    
    
    // Outlet connections
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var smallestLabel: UILabel!
    @IBOutlet weak var largestLabel: UILabel!
    @IBOutlet weak var informationTableView: UITableView!
    
    // Api Client
    let client = StarwarsAPIClient()
    
    // MARK: View Did Load Method
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Setting the navigation title to what button the user hit
        navigationController?.navigationBar.isHidden = false
        navigationItem.title = navigationTitle
        
    }
    
    // If the back button is clicked...
    override func viewWillDisappear(_ animated: Bool) {
        
        // make the navigation controller hide
        navigationController?.navigationBar.isHidden = true

    }
    

    // ==========================================
    // MARK: TableView Data Source
    // ==========================================
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        // I create two cells
        // One thats designed to display information
        let normalAttributeCell = tableView.dequeueReusableCell(withIdentifier: NormalTableViewCell.reuseIdentifier, for: indexPath) as! NormalTableViewCell
        
        // One thats designed to display units that need to be converted between two measurement standards
        let convertableAttributeCell = tableView.dequeueReusableCell(withIdentifier: ConvertableUnitTableViewCell.reuseIdentifer, for: indexPath) as! ConvertableUnitTableViewCell
        
        
        // Check to see if its a machene type or a character type
        if currentObject.type == .character {
            // Switch on the current row of the tableview
            // The title of every row is already predetermined and all we do here is take the title we want to assign and the value and create a ViewModel instance for that combination

            switch indexPath.row {
                case 0:
                    
                    let viewModel = NormalCellViewModel(title: "Born", item: currentObject.attribute1)
                    normalAttributeCell.configure(with: viewModel)
                    
                    return normalAttributeCell
                    
                case 1:
                    let viewModel = NormalCellViewModel(title: "Home", item: currentObject.arrtibute2)
                    normalAttributeCell.configure(with: viewModel)
                    
                    return normalAttributeCell
                    
                case 2:
                    let viewModel = ConvertableCellViewModel(title: "Height", item: Double(currentObject.attribute3)!, unit: .centimeters, convertedUnit: .feet)
                    convertableAttributeCell.configure(viewModel: viewModel)
                    
                    return convertableAttributeCell
                    
                case 3:
                    let viewModel = NormalCellViewModel(title: "Eyes", item: currentObject.attribute4)
                    normalAttributeCell.configure(with: viewModel)
                    
                    return normalAttributeCell
                    
                case 4:
                    let viewModel = NormalCellViewModel(title: "Hair", item: currentObject.attribute5)
                    normalAttributeCell.configure(with: viewModel)
                    
                    return normalAttributeCell
                    
                default:
                    fatalError()
                }
        } else {
            switch indexPath.row {
                case 0:
                    
                    let viewModel = NormalCellViewModel(title: "Make", item: currentObject.attribute1)
                    normalAttributeCell.configure(with: viewModel)
                    
                    return normalAttributeCell
                    
                case 1:
                    
                    let viewModel = ConvertableCellViewModel(title: "Cost", item: Double(currentObject.arrtibute2) ?? 0, unit: .credits, convertedUnit: .USD)
                    convertableAttributeCell.configure(viewModel: viewModel)
                    
                    return convertableAttributeCell
                    
                case 2:
                    let viewModel = ConvertableCellViewModel(title: "Length", item: Double(currentObject.attribute3) ?? 0, unit: .centimeters, convertedUnit: .feet)
                    convertableAttributeCell.configure(viewModel: viewModel)
                    
                    return convertableAttributeCell
                    
                case 3:
                    let viewModel = NormalCellViewModel(title: "Class", item: currentObject.attribute4)
                    normalAttributeCell.configure(with: viewModel)
                    
                    return normalAttributeCell
                    
                case 4:
                    let viewModel = NormalCellViewModel(title: "Crew", item: currentObject.attribute5)
                    normalAttributeCell.configure(with: viewModel)
                    
                    return normalAttributeCell
                    
                default:
                    fatalError()
                }
            }
        }
    
        
        
    
    
    // ==========================================
    // MARK: Picker Data Source
    // ==========================================
    
    
    
    // Number of columns of data
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return currentObjects.count
    }
    
    // The data to return fopr the row and component (column) that's being passed in
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return currentObjects[row].title
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        print("Current Row: \(row)")
        titleLabel.text = currentObjects[row].title
        currentObject = currentObjects[row]
        
//        // When
//        client.lookupPlanet(withURL: currentObjects[row].homeworld) { planet, error in
//            self.planet = planet
//            self.informationTableView.reloadData()
//
//        }
        
        informationTableView.reloadData()
        
    }
    
    // ==========================================
    // MARK: MISC Functions
    // ==========================================
    
    // sets the item with the largest units
    func setBiggest() {
        var biggest = currentObjects[0]
       
        for object in currentObjects {
            if object.sizeAttribute > biggest.sizeAttribute {
                biggest = object
            }
        }
       
       largestLabel.text = biggest.title
    }
       
    // sets the item with the smallest units
    func setSmallest() {
        var smallest = currentObjects[0]
       
        for object in currentObjects {
            if object.sizeAttribute < smallest.sizeAttribute {
                smallest = object
            }
        }
       
       smallestLabel.text = smallest.title
    }
    
    // some misc functions that run when this view is displayed
    func firstTimeSetup() {
        
        informationTableView.dataSource = self
        informationTableView.reloadData()
        
        picker.delegate = self
        picker.dataSource = self
        
    }
}
