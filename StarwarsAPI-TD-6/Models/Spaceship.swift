//
//  SpaceShip.swift
//  StarwarsAPI-TD-6
//
//  Created by Andrew Graves on 8/24/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//

import Foundation

class Spaceship {
    let name: String
    let model: String
    let starshipClass: String
    let manufacturer: String
    let costInCredits: Double
    let length: Double
    let crew: Int
    let url: URL
    
    init(name: String, model: String, starshipClass: String, manufacturer: String, costInCredits: Double, length: Double, crew: Int, passengers: Int, maxAtmospheringSpeed: Double, MGLT: Double, cargoCapacity: Double, consumables: Double, films: [URL], pilots: [URL], url: URL, created: Date,  edited: Date) {
        self.name = name
        self.model = model
        self.starshipClass = starshipClass
        self.manufacturer = manufacturer
        self.costInCredits = costInCredits
        self.length = length
        self.crew = crew
        self.url = url
        
    }
}
