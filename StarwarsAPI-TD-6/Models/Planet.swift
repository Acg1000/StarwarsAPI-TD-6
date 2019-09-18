//
//  Planet.swift
//  StarwarsAPI-TD-6
//
//  Created by Andrew Graves on 8/24/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//

import Foundation

class Planet {
    let name: String
    
    init(name: String) {
        self.name = name

    }
}

extension Planet {
    convenience init?(json: [String: Any]) {
        
        struct Key {
            static let name = "name"
        
        }
        
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US_POSIX")
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZZZZZ"
        
        guard let nameValue = json[Key.name] as? String
                else { return nil }
        
        self.init(name: nameValue)
        
    }
}
