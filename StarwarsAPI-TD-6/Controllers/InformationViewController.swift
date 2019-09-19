//
//  InformationViewController.swift
//  StarwarsAPI-TD-6
//
//  Created by Andrew Graves on 9/13/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//

import UIKit

class InformationViewController: UIViewController {
    
    
    
    //    let currentInformationItem: InformationItems = {
    //        return
    //    }
    
    //    lazy var dataSource: PersonDataSource = {
    //        return PersonDataSource(person: Person(json: []), tableView: [])
    //    }()
    //    lazy var dataSource: DataSource = {
    //        return
    //    }
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var picker: UIPickerView!
    @IBOutlet weak var smallestLabel: UILabel!
    @IBOutlet weak var largestLabel: UILabel!
    @IBOutlet weak var informationTableView: UITableView!
    
    
    let client = StarwarsAPIClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //        let dataSource = PersonDataSource( person: Person(name: "owowow", birthYear: "WOWO", eyeColor: "blue", hairColor: "red", height: 99, homeworld: URL(string: "https://apple.com")!, url: URL(string: "https://apple.com")!), tableView: informationTableView)
        
        let dataSource = TestingDataSource()
        
        print(dataSource.contacts)
        
        informationTableView.dataSource = dataSource
        informationTableView.reloadData()
        
        print("Called")
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
