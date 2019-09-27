//
//  Endpoint.swift
//  StarwarsAPI-TD-6
//
//  Created by Andrew Graves on 8/25/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//

import Foundation

protocol Endpoint {
    var base: String { get }
    var path: String { get }
}

extension Endpoint {
    var urlComponents: URLComponents {
        var components = URLComponents(string: base)!
        components.path = path
        
        return components
    }
    
    var request: URLRequest {
        let url = urlComponents.url!
        return URLRequest(url: url)
    }
}

enum Starwars: Endpoint {
//    case search(resource: StarwarsResource, id: Int?)
    case character(id: Int?)
    case starships(id: Int?)
    case planets(id: Int)
    case vehicles(id: Int?)

    
    var base: String {
        return "https://swapi.co"
        
    }
    
    var path: String {
        switch self {
        case .character(let id):
            if let id = id {
                return "/api/people/\(id)"
                
            } else {
                return "/api/people"

            }
            
        case .planets(let id):
            return "/api/planets/\(id)"
            
        case .starships(let id):
            if let id = id {
                return "/api/starships/\(id)"
                
            } else {
                return "/api/starships"
                
            }
            
        case .vehicles(let id):
            if let id = id {
                return "/api/vehicles/\(id)"
            } else {
                return "/api/vehicles"
            }
        }
    }
}
