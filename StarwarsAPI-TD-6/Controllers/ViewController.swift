//
//  ViewController.swift
//  StarwarsAPI-TD-6
//
//  Created by Andrew Graves on 8/24/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let client = StarwarsAPIClient()
    
    var objects = [Object]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationController?.navigationBar.isHidden = true
        print("AT THE MAIN VIEW CONTROLLER")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let informationViewController = segue.destination as! InformationViewController

        if segue.identifier == "characterSegue" {
            
            informationViewController.navigationTitle = "Characters"
            
            client.getCharacters() { [weak self] characters, error in
                self?.objects = characters
                
                informationViewController.currentObjects = characters
                informationViewController.currentObject = characters[0]
                informationViewController.titleLabel.text = characters[0].name
                
                informationViewController.setBiggest()
                informationViewController.setSmallest()
                
                informationViewController.firstTimeSetup()

            }
        } else if segue.identifier == "vehicleSegue" {
            
            informationViewController.navigationTitle = "Vehicles"
            
            client.getVehicles() { [weak self] vehicles, error in
                self?.objects = vehicles
                
                informationViewController.currentObjects = vehicles
                informationViewController.currentObject = vehicles[0]
                informationViewController.titleLabel.text = vehicles[0].name

                informationViewController.setBiggest()
                informationViewController.setSmallest()
                
                informationViewController.firstTimeSetup()

            }
        } else if segue.identifier == "starshipSegue" {
            
            informationViewController.navigationTitle = "Starships"
            
            client.getStarships() { [weak self] starships, error in
                self?.objects = starships
                
                informationViewController.currentObjects = starships
                informationViewController.currentObject = starships[0]
                informationViewController.titleLabel.text = starships[0].name

                informationViewController.setBiggest()
                informationViewController.setSmallest()
                
                informationViewController.firstTimeSetup()

            }
        }
    }
}

