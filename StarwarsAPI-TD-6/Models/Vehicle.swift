//
//  Vehicles.swift
//  StarwarsAPI-TD-6
//
//  Created by Andrew Graves on 8/24/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//
//  Function: Model the Vehicle type...

import Foundation

class Vehicle: Codable {
    let name: String
    let model: String
    let vehicleClass: String
    let manufacturer: String
    let length: String
    let costInCredits: String
    let crew: String
    
    
    init() {
        
        self.name = ""
        self.model = ""
        self.vehicleClass = ""
        self.manufacturer = ""
        self.length = ""
        self.costInCredits = ""
        self.crew = ""
        
    }
}

// MARK: Object class conformance

extension Vehicle: Object {
    var title: String {
        return name
    }
    
    var sizeAttribute: Double {
        return Double(length)!
    }
    
    var type: StarwarsResource {
        return .vehicle
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
        return vehicleClass
    }
    
    var attribute5: String {
        return crew
    }
    
    
}
