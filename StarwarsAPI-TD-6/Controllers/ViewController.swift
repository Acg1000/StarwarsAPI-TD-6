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

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        print("AT THE MAIN VIEW CONTROLLER")
        
        client.getPlanets() { [weak self] planets, error in
            self?.planets = planets
//
//            print(self?.planets[0].name)
//            print(self?.planets[1].name)
        }
    }
}

