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
        
        
        // THIS IS THE FAULTY CALL... SOMTHING IS HAPPENING HERE
        client.lookupPlanet(withURL: "https://swapi.co/api/planets/1/") { [weak self] planet, error in
            print("Planet object: \(planet)")
            print("Planet name: \(planet.name)")

        }
    }
    
    // when a segue is clicked...
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        // Create a reference to the information view controller...
        let informationViewController = segue.destination as! InformationViewController

        // Check to see if the seque identifier matches one of the three set ones
        if segue.identifier == "characterSegue" {
            
            // Set the title of the navigation controller on the next page
            informationViewController.navigationTitle = "Characters"
            
            // Call the client for the information
            client.getCharacters() { [weak self] characters, error in
                self?.objects = characters
                
                // Assign the info gotten to the different varables
                informationViewController.currentObjects = characters
                informationViewController.currentObject = characters[0]
                informationViewController.titleLabel.text = characters[0].name
                
                // Run the functions to get the biggest and smallest items
                informationViewController.setBiggest()
                informationViewController.setSmallest()
                
                // Run some other setup things
                informationViewController.firstTimeSetup()

            }
        } else if segue.identifier == "vehicleSegue" {
            
            // Set the title of the navigation controller on the next page
            informationViewController.navigationTitle = "Vehicles"
            
            // Call the client for the information
            client.getVehicles() { [weak self] vehicles, error in
                self?.objects = vehicles
                
                // Assign the info gotten to the different varables
                informationViewController.currentObjects = vehicles
                informationViewController.currentObject = vehicles[0]
                informationViewController.titleLabel.text = vehicles[0].name

                // Run the functions to get the biggest and smallest items
                informationViewController.setBiggest()
                informationViewController.setSmallest()
                
                // Run some other setup things
                informationViewController.firstTimeSetup()

            }
        } else if segue.identifier == "starshipSegue" {
            
            // Set the title of the navigation controller on the next page
            informationViewController.navigationTitle = "Starships"
            
            // Call the client for the information
            client.getStarships() { [weak self] starships, error in
                self?.objects = starships
                
                // Assign the info gotten to the different varables
                informationViewController.currentObjects = starships
                informationViewController.currentObject = starships[0]
                informationViewController.titleLabel.text = starships[0].name

                // Run the functions to get the biggest and smallest items
                informationViewController.setBiggest()
                informationViewController.setSmallest()
                
                // Run some other setup things
                informationViewController.firstTimeSetup()

            }
        }
    }
}

