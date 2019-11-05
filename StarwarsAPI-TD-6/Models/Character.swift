//
//  Person.swift
//  StarwarsAPI-TD-6
//
//  Created by Andrew Graves on 8/24/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//
//  Function: Model the Character

import Foundation

class Character: Codable {
    let name: String
    let birthYear: String
    let eyeColor: String
    let hairColor: String
    let height: String
    var homeworld: String
    let url: String

    init() {
        name = ""
        birthYear = ""
        eyeColor = ""
        hairColor = ""
        height = ""
        homeworld = ""
        url = ""
    }
}

extension Character: Object {
   
    var title: String {
        return name
    }
    
    var sizeAttribute: Double {
        return Double(height) ?? 0
    }
    
    // Create a Size Attribute #2 for conversion...
    
    var type: StarwarsResource {
        return .character
    }
    
    var attribute1: String {
        return birthYear
    }
    
    var attribute2: String {
        get {
            return homeworld

        } set  {
            homeworld = newValue
            
        }
    }
    
    var attribute3: String {
        return height
    }
    
    var attribute4: String {
        return eyeColor
    }
    
    var attribute5: String {
        return hairColor
    }
}
