//
//  StarwarsResourses.swift
//  StarwarsAPI-TD-6
//
//  Created by Andrew Graves on 8/25/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//
//  Function: Model the different types that can exist

import Foundation

enum StarwarsResource: String {
    case character
    case starship
    case vehicle
}

extension StarwarsResource: CustomStringConvertible {
    var description: String {
        switch self {
        case .character: return "people"
        case .starship: return "starship"
        case .vehicle: return "vehicle"
            
        }
    }
}
