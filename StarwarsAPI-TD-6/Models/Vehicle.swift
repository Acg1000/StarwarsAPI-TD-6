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
    let lengthInCM: String
    let costInCredits: String
    let crew: String
    
    init(name: String, model: String, vehicleClass: String, manufacturer: String, costInCredits: String, length: String, crew: String) {
        
        self.name = name
        self.model = model
        self.vehicleClass = vehicleClass
        self.manufacturer = manufacturer
        self.lengthInCM = length
        self.costInCredits = costInCredits
        self.crew = crew
        
    }
}

// MARK: JSON init

extension Vehicle {
    convenience init?(json: [String: Any]) {
        
        struct Key {
            static let name = "name"
            static let model = "model"
            static let vehicleClass = "vehicle_class"
            static let manufacturer = "manufacturer"
            static let costInCredits = "cost_in_credits"
            static let length = "length"
            static let crew = "crew"
            
        }
        
        guard let nameValue = json[Key.name] as? String,
            let modelValue = json[Key.model] as? String,
            let vehicleClassValue = json[Key.vehicleClass] as? String,
            let manufacturerValue = json[Key.manufacturer] as? String,
            let costInCreditsValue = json[Key.costInCredits] as? String,
            let lengthValue = json[Key.length] as? String,
            let crewValue = json[Key.crew] as? String
            else { return nil }
        
        self.init(name: nameValue, model: modelValue, vehicleClass: vehicleClassValue, manufacturer: manufacturerValue, costInCredits: costInCreditsValue, length: lengthValue, crew: crewValue)
    }
}


// MARK: Object class conformance

extension Vehicle: Object {
    var title: String {
        return name
    }
    
    var sizeAttribute: Double {
        return Double(lengthInCM)!
    }
    
    var type: StarwarsResource {
        return .vehicle
    }
    
    var attribute1: String {
        return manufacturer
    }
    
   var arrtibute2: String {
        get {
            return costInCredits
        } set {
            
        }
    }
    
    var attribute3: String {
        return lengthInCM
    }
    
    var attribute4: String {
        return vehicleClass
    }
    
    var attribute5: String {
        return crew
    }
    
    
}
