//
//  Person.swift
//  StarwarsAPI-TD-6
//
//  Created by Andrew Graves on 8/24/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//

import Foundation

class Person {
    let name: String
    let birthYear: String
    let eyeColor: String
    let hairColor: String
    let height: Double
    let homeworld: URL
    let url: URL

    init(name: String, birthYear: String, eyeColor: String, hairColor: String, height: Double, homeworld: URL, url: URL) {
        self.name = name
        self.birthYear = birthYear
        self.eyeColor = eyeColor
        self.hairColor = hairColor
        self.height = height
        self.homeworld = homeworld
        self.url = url
        
    }
}

extension Person {
    convenience init?(json: [String: Any]) {
        
        struct Key {
            static let name = "name"
            static let birthYear = "birthYear"
            static let eyeColor = "eyeColor"
            static let hairColor = "hairColor"
            static let height = "height"
            static let homeworld = "homeworld"
            static let url = "url"
            
        }
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        guard let nameValue = json[Key.name] as? String,
            let birthYearValue = json[Key.birthYear] as? String,
            let eyeColorValue = json[Key.eyeColor] as? String,
            let hairColorValue = json[Key.hairColor] as? String,
            let heightValue = json[Key.height] as? Double,
            let homeworldURL = json[Key.homeworld] as? URL,
            let urlValue = json[Key.url] as? URL
            else { return nil }
        
        self.init(name: nameValue, birthYear: birthYearValue, eyeColor: eyeColorValue, hairColor: hairColorValue, height: heightValue, homeworld: homeworldURL, url: urlValue) 
    }
}

//extension Person {
//    convenience init(json: [String: Any]) {
//        
//        struct Key {
//            let name = "name"
//            let birthYear = "birthYear"
//            let eyeColor = "eyeColor"
//            let gender = "gender"
//            let hairColor = "hairColor"
//            let height = "height"
//            let mass = "mass"
//            let skinColor = "skinColor"
//            let homeworld = "homeworld"
//            let films = "films"
//            let species = "species"
//            let starships = "starships"
//            let vehicles = "vehicles"
//            let url = "url"
//            let created = "created"
//            let edited = "edited"
//        }
//        
//        guard let 
//    }
//}

//extension Planet {
//    convenience init?(json: [String: Any]) {
//
//        struct Key {
//            static let name = "name"
//            static let diameter = "diameter"
//            static let rotationPeriod = "rotationPeriod"
//            static let orbitalPeriod = "orbitalPeriod"
//            static let gravity = "gravity"
//            static let population = "population"
//            static let climate = "climate"
//            static let terrain = "terrain"
//            static let surfaceWater = "surfaceWater"
//            static let residents = "residents"
//            static let films = "films"
//            static let url = "url"
//            static let created = "created"
//            static let edited = "edited"
//        }
//
//        let formatter = DateFormatter()
//        formatter.locale = Locale(identifier: "en_US_POSIX")
//        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
//
//        guard let nameValue = json[Key.name] as? String,
//            let diameterValue = json[Key.diameter] as? Double,
//            let rotationPeriodValue = json[Key.rotationPeriod] as? Double,
//            let orbitalPeriodValue = json[Key.orbitalPeriod] as? Double,
//            let gravityValue = json[Key.gravity] as? Double,
//            let populationValue = json[Key.population] as? Int,
//            let climateValue = json[Key.climate] as? String,
//            let terrainValue = json[Key.terrain] as? String,
//            let surfaceWaterValue = json[Key.surfaceWater] as? Int,
//            let residentsValue = json[Key.residents] as? [URL],
//            let filmsValue = json[Key.films] as? [URL],
//            let urlValue = json[Key.url] as? URL,
//            let createdValue = json[Key.created] as? Date,
//            let editedValue = json[Key.edited] as? Date
//            else { return nil }
//
//        self.init(name: nameValue, diameter: diameterValue, rotationPeriod: rotationPeriodValue, orbitalPeriod: orbitalPeriodValue, gravity: gravityValue, population: populationValue, climate: climateValue, terrain: terrainValue, surfaceWater: surfaceWaterValue, residents: residentsValue, films: filmsValue, url: urlValue, created: createdValue, edited: editedValue)
//
//    }
//}
