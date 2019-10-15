//
//  SpaceShip.swift
//  StarwarsAPI-TD-6
//
//  Created by Andrew Graves on 8/24/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//
//  Function: Model the Starship type...

import Foundation

class Starship {
    let name: String
    let model: String
    let starshipClass: String
    let manufacturer: String
    let costInCredits: String
    let lengthInCM: String
    let crew: String
    
    init(name: String, model: String, starshipClass: String, manufacturer: String, costInCredits: String, length: String, crew: String) {
        self.name = name
        self.model = model
        self.starshipClass = starshipClass
        self.manufacturer = manufacturer
        self.costInCredits = costInCredits
        self.lengthInCM = length
        self.crew = crew
        
    }
}

// MARK: Json init

extension Starship {
    convenience init?(json: [String: Any]) {
        
        struct Key {
            static let name = "name"
            static let model = "model"
            static let starshipClass = "starship_class"
            static let manufacturer = "manufacturer"
            static let costInCredits = "cost_in_credits"
            static let length = "length"
            static let crew = "crew"
            
        }
        
        guard let nameValue = json[Key.name] as? String,
            let modelValue = json[Key.model] as? String,
            let starshipClassValue = json[Key.starshipClass] as? String,
            let manufacturerValue = json[Key.manufacturer] as? String,
            let costInCreditsValue = json[Key.costInCredits] as? String,
            let lengthValue = json[Key.length] as? String,
            let crewValue = json[Key.crew] as? String
            else { return nil }
        
        self.init(name: nameValue, model: modelValue, starshipClass: starshipClassValue, manufacturer: manufacturerValue, costInCredits: costInCreditsValue, length: lengthValue, crew: crewValue)
    }
}

// MARK: Object class conformance

extension Starship: Object {
    var title: String {
        return name
    }
    
    var sizeAttribute: Double {
        return Double(lengthInCM)!
    }
    
    var type: StarwarsResource {
        return .starship
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
        return starshipClass
    }
    
    var attribute5: String {
        return crew
    }
}
