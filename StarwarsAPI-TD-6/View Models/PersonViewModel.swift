//
//  PersonViewModel.swift
//  StarwarsAPI-TD-6
//
//  Created by Andrew Graves on 9/12/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//

import Foundation
import UIKit

struct PersonViewModel {
    let name: String
    let birthYear: String
    let eyeColor: String
    let hairColor: String
    let heightInFeet: Double
    let heightInMeters: Double
    let homeworld: String
}

extension PersonViewModel {
    init(person: Person) {
        self.name = person.name
        self.birthYear = person.birthYear
        self.eyeColor = person.eyeColor
        self.hairColor = person.hairColor
        
        // converting from cm to feet
        self.heightInFeet = person.height / 30.48
        
        // converting from cm to meters
        self.heightInMeters = person.height / 100
        
        // Call the URl and get the homeworld
        self.homeworld = "TBD"
    }
}
