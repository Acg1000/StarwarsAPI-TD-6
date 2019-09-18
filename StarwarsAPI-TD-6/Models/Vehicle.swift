//
//  Vehicles.swift
//  StarwarsAPI-TD-6
//
//  Created by Andrew Graves on 8/24/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//

import Foundation

class Vehicle {
    let name: String
    let model: String
    let vehicleClass: String
    let manufacturer: String
    let length: Double
    let costInCredits: Double
    let crew: Int
    
    init(name: String, model: String, vehicleClass: String, manufacturer: String, length: Double, costInCredits: Double, crew: Int) {
        
        self.name = name
        self.model = model
        self.vehicleClass = vehicleClass
        self.manufacturer = manufacturer
        self.length = length
        self.costInCredits = costInCredits
        self.crew = crew
        
    }
}
