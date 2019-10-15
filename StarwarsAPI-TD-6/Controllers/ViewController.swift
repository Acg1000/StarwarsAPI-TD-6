//
//  ViewController.swift
//  StarwarsAPI-TD-6
//
//  Created by Andrew Graves on 8/24/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//
//  Function: Starting View Controller

import UIKit

class ViewController: UIViewController {
    
    let client = StarwarsAPIClient()
    
    var objects = [Object]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.isHidden = true
        
    }
    
    // when a segue is clicked...
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Create a reference to the information view controller...
        let informationViewController = segue.destination as! InformationViewController

        // Check to see if the seque identifier matches one of the three set ones
        if segue.identifier == "characterSegue" {
            
            // Set the title of the navigation controller on the next page
            informationViewController.navigationTitle = "Characters"
            
            informationViewController.getData(for: .character)
            
            
        } else if segue.identifier == "vehicleSegue" {
            
            // Set the title of the navigation controller on the next page
            informationViewController.navigationTitle = "Vehicles"
            
            informationViewController.getData(for: .vehicle)
            
            
        } else if segue.identifier == "starshipSegue" {
            
            // Set the title of the navigation controller on the next page
            informationViewController.navigationTitle = "Starships"
            
            informationViewController.getData(for: .starship)
            
        }
    }
}

