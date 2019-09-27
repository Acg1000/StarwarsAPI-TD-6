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
    
    func getCharacters(completion: @escaping ([Character], StarwarsError?) -> Void) {
        let endpoint = Starwars.character(id: nil)
        
        preformRequest(with: endpoint) { results, error in
            guard let results = results else {
                print("ERROR WITH CHARACTER RESULTS: Endpoint: \(endpoint.base + endpoint.path)")
                completion([], error)
                return
            }
                        
            let characters = results.compactMap { Character(json: $0) }
//            print("characters: \(characters)")
            
            completion(characters, nil)
        }
    }
    
    func getVehicles(completion: @escaping ([Vehicle], StarwarsError?) -> Void) {
        let endpoint = Starwars.vehicles(id: nil)
        
        preformRequest(with: endpoint) { results, error in
            guard let results = results else {
                print("ERROR WITH VEHICLE RESULTS: \(endpoint.base + endpoint.path)")
                completion([], error)
                return
            }
           
            let vehicles = results.compactMap { Vehicle(json: $0) }
            
            completion(vehicles, nil)
        }
    }
    
    func getStarships(completion: @escaping ([Starship], StarwarsError?) -> Void) {
        let endpoint = Starwars.starships(id: nil)
        
        preformRequest(with: endpoint) { results, error in
            guard let results = results else {
                print("ERROR WITH VEHICLE RESULTS: \(endpoint.base + endpoint.path)")
                completion([], error)
                return
            }
            
            print("results: \(results)")
            let starships = results.compactMap { Starship(json: $0) }
            print("MAPPING:  \(results.map { Starship(json: $0)})")
           
            print("Starships: \(starships)")
           
            completion(starships, nil)
        }
    }
    
    
    func lookupPlanet(withURL url: String, completion: @escaping (Planet, StarwarsError?) -> Void) {
        var id: Int = 0
        
        for char in url {
            if char.isNumber {
                if let number = Int(String(char)) {
                    print(number)
                    print("ID Before: \(id)")
                    id = number
                    print("ID After: \(id)")

                }
            }
        }
        
        let endpoint = Starwars.planets(id: id)
        print("Looking up planet: \(endpoint.request)")

        
        preformRequest(with: endpoint) { results, error in
            print("Results: \(results)")
            guard let results = results else {
                print("ERROR WITH RESULTS: Endpoint: -\(endpoint)-")
                completion(Planet(name: "n/a"), error)
                return
            }
            
            print("plannet result: \(results)")
            
            let planetName = results.first
            
            print("RESULTS \(results)")
            print("PLANET NAME: \(planetName)")
            
            
            completion(Planet(name: "HAHAHHA"), nil)
        }
    }
    
    
    
    
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
