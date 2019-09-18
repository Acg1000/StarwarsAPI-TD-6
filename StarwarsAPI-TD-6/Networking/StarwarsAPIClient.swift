//
//  StarwarsAPIClient.swift
//  StarwarsAPI-TD-6
//
//  Created by Andrew Graves on 8/26/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//

import Foundation

class StarwarsAPIClient {
    
    let downloader = JSONDownloader()
    
    
    func getPlanets(completion: @escaping ([Planet], StarwarsError?) -> Void) {
        let endpoint = Starwars.planets(id: nil)
        
        preformRequest(with: endpoint) { results, error in
            guard let results = results else {
                completion([], error)
                return
            }
            
            let planets = results.flatMap { Planet(json: $0)}
            
            print(planets)
            
            completion(planets, nil)
//            print("Results incoming")
//            print(planets)
//            print(planets.count)
        }
    }
    
    func lookupPlanet(withId id: Int, completion: @escaping (Planet, StarwarsError?) -> Void) {
        let endpoint = Starwars.planets(id: id)
    }
    
//    func getPerson(completion: @escaping ([Person], StarwarsError?) -> Void) {
//        let endpoint = Starwars.people(id: nil)
//        
//        preformRequest(with: endpoint) { results, error in
//            guard let results = results else {
//                completion([], error)
//                return
//            }
//
//            print("Results incoming")
//
//        }
//    }
    
    
    
    
    
    typealias Results = [[String: Any]]
    
    private func preformRequest(with endpoint: Endpoint, completion: @escaping(Results?, StarwarsError?) -> Void) {
        
        let task = downloader.jsonTask(with: endpoint.request) {json, error in
            DispatchQueue.main.async {
                guard let json = json else {
                    completion(nil, error)
                    return
                }
                
                guard let results = json["results"] as? [[String: Any]] else {
                    completion(nil, .jsonParsingFailure(messege: "JSON data does not contain results"))
                    return
                }
                
                completion(results, nil)
            }
        }
        
        task.resume()
    }
}
