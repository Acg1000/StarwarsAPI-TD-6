//
//  StarwarsResourses.swift
//  StarwarsAPI-TD-6
//
//  Created by Andrew Graves on 8/25/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//

import Foundation

enum StarwarsResource {
    case people
    case starships
    case planets
}

extension StarwarsResource: CustomStringConvertible {
    var description: String {
        switch self {
        case .people: return "people"
        case .starships: return "starships"
        case .planets: return "planets"
            
        }
    }
}
