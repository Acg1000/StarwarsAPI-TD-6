//
//  Planet.swift
//  StarwarsAPI-TD-6
//
//  Created by Andrew Graves on 8/24/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//
//  Function: Model the Planet type...

import Foundation

class Planet {
    let name: String
    
    init(name: String) {
        self.name = name

    }
}

// MARK: JSON init

extension Planet {
    convenience init?(json: [String: Any]) {
        
        struct Key {
            static let name = "name"
        
        }
        
        guard let nameValue = json[Key.name] as? String
                else { return nil }
        
        self.init(name: nameValue)
        
    }
}
