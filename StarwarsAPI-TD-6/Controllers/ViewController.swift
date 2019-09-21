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
    
    var planets = [Planet]()
    var characters = [Character]()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("AT THE MAIN VIEW CONTROLLER")
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "characterSegue" {
            client.getCharacters() { [weak self] characters, error in
                self?.characters = characters
                
                let informationViewController = segue.destination as! InformationViewController
                
                self?.client.getCharacters() { characters, error in
                    informationViewController.characters = characters
                    informationViewController.character = characters[0]
                    informationViewController.titleLabel.text = characters[0].name
                    
                    informationViewController.setBiggest()
                    informationViewController.setSmallest()

                    
                    informationViewController.informationTableView.reloadData()
                }
            }
        }
    }
}

