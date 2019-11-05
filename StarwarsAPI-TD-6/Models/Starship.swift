//
//  SpaceShip.swift
//  StarwarsAPI-TD-6
//
//  Created by Andrew Graves on 8/24/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//
//  Function: Model the Starship type...

import Foundation

class Starship: Codable {
    let name: String
    let model: String
    let starshipClass: String
    let manufacturer: String
    let costInCredits: String
    let length: String
    let crew: String
    
    init() {
        self.name = ""
        self.model = ""
        self.starshipClass = ""
        self.manufacturer = ""
        self.costInCredits = ""
        self.length = ""
        self.crew = ""
        
    }
}

// MARK: Object class conformance

extension Starship: Object {
    var title: String {
        return name
    }
    
    var sizeAttribute: Double {
        return Double(length)!
    }
    
    var type: StarwarsResource {
        return .starship
    }
    
    var attribute1: String {
        return manufacturer
    }
    
    var attribute2: String {
        get {
            return costInCredits
        } set {
            
        }
    }
    
    var attribute3: String {
        return length
    }
    
    var attribute4: String {
        return starshipClass
    }
    
    var attribute5: String {
        return crew
    }
}
