//
//  Person.swift
//  StarwarsAPI-TD-6
//
//  Created by Andrew Graves on 8/24/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//
//  Function: Model the Character

import Foundation

class Character {
    let name: String
    let birthYear: String
    let eyeColor: String
    let hairColor: String
    let height: Double
    var homeworld: String
    let url: String

    init(name: String, birthYear: String, eyeColor: String, hairColor: String, height: Double, homeworld: String, url: String) {
        self.name = name
        self.birthYear = birthYear
        self.eyeColor = eyeColor
        self.hairColor = hairColor
        self.height = height
        self.homeworld = homeworld
        self.url = url
        
    }
}

extension Character {
    convenience init?(json: [String: Any]) {
        
        struct Key {
            static let name = "name"
            static let birthYear = "birth_year"
            static let eyeColor = "eye_color"
            static let hairColor = "hair_color"
            static let height = "height"
            static let homeworld = "homeworld"
            static let url = "url"
            
        }
        
        guard let nameValue = json[Key.name] as? String,
            let birthYearValue = json[Key.birthYear] as? String,
            let eyeColorValue = json[Key.eyeColor] as? String,
            let hairColorValue = json[Key.hairColor] as? String,
            let heightString = json[Key.height] as? String,
            let heightValue = Double(heightString),
            let homeworldURL = json[Key.homeworld] as? String,
            let urlValue = json[Key.url] as? String
            else { return nil }
        
        self.init(name: nameValue, birthYear: birthYearValue, eyeColor: eyeColorValue, hairColor: hairColorValue, height: heightValue, homeworld: homeworldURL, url: urlValue) 
    }
}

extension Character: Object {
   
    
    var title: String {
        return name
    }
    
    var sizeAttribute: Double {
        return height
    }
    
    var type: StarwarsResource {
        return .character
    }
    
    var attribute1: String {
        return birthYear
    }
    
    var arrtibute2: String {
        get {
            return homeworld

        } set  {
            homeworld = newValue
            
        }
    }
    
    var attribute3: String {
        return "\(height)"
    }
    
    var attribute4: String {
        return eyeColor
    }
    
    var attribute5: String {
        return hairColor
    }
}
