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
    case people(id: Int?)
    case starships(id: Int?)
    case planets(id: Int?)

    
    var base: String {
        print("getting base")
        return "https://swapi.co"
    }
    
    var path: String {
        print("getting path")
        switch self {
        case .people(let id):
            if let id = id {
                return "/people/\(id)"
                
            } else {
                return "/people"

            }
            
        case .planets(let id):
            if let id = id {
                print("Calling peopleid")

                return "/api/planets/\(id)"
                
            } else {
                print("calling people")

                return "/api/planets"
                
            }
        case .starships(let id):
            if let id = id {
                return "/starships/\(id)"
                
            } else {
                return "/starships"
                
            }
            
        }
    }
}
