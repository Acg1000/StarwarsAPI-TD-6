//
//  StarwarsAPIClient.swift
//  StarwarsAPI-TD-6
//
//  Created by Andrew Graves on 8/26/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//
// Function: Provides the methods needed to get information from the API

import Foundation

class StarwarsAPIClient {
    
    let downloader = JSONDownloader()
    
    // MARK: getCharacters
    
    // get characters method
    func getCharacters(completion: @escaping ([Character], StarwarsError?) -> Void) {
        
        // Create the endpoint and pass nil because we want all the characters
        let endpoint = Starwars.character(id: nil)
        
        // Call the preform request function with the URL / endpoint that wejust created
        preformRequest(with: endpoint) { results, error in
            
            // When we get results back...
            guard let results = results else {
                // if they do not exist, then pass an error
                
                completion([], error)
                return
            }
                        
            // If they do then case / map them to the Character class and then pass through the completion handeler
            let characters = results.compactMap { Character(json: $0) }
            var counter = 0
            
            for character in characters {
                self.lookupPlanet(withURL: character.arrtibute2) { planet, error in
                    character.arrtibute2 = planet.name
                    completion(characters, nil)
                    counter += 1

                }
                if counter == characters.count {
                    completion(characters, nil)

                }
            }
        }
    }
    
    // MARK: getVehicles
    
    // get vehicles method
    func getVehicles(completion: @escaping ([Vehicle], StarwarsError?) -> Void) {
        
        // Create endpoint
        let endpoint = Starwars.vehicles(id: nil)
        
        // Call the endpoint provided
        preformRequest(with: endpoint) { results, error in
            
            // when the results come back...
            guard let results = results else {
                // if the results don't exist...
                
                completion([], error)
                return
            }
           
            // If they do then cast / map them to the Vehivle class and then pass through the completion handeler
            let vehicles = results.compactMap { Vehicle(json: $0) }
            
            completion(vehicles, nil)
        }
    }
    
    // MARK: getStarships
    
    // get starships method
    func getStarships(completion: @escaping ([Starship], StarwarsError?) -> Void) {
        
        // Create endpoint
        let endpoint = Starwars.starships(id: nil)
        
        // Call the endpoint provided
        preformRequest(with: endpoint) { results, error in
            
            // when the results come back
            guard let results = results else {
                // If the results don't exist...

                completion([], error)
                return
            }
            
            // If they do then cast / map them to the starship class and then pass through completion hendler
            let starships = results.compactMap { Starship(json: $0) }
            completion(starships, nil)
        }
    }
    
    // MARK: lookupPlannet
    
    // lookupPlannet method
    func lookupPlanet(withURL url: String, completion: @escaping (Planet, StarwarsError?) -> Void) {
        var id: Int = 0
        
        for char in url {
            if char.isNumber {
                if let number = Int(String(char)) {
                    print(number)
                    id = number

                }
            }
        }
        
        let endpoint = Starwars.planets(id: id)
        print("Looking up planet: \(endpoint.request)")

        
        preformSingleRequest(with: endpoint) { result, error in

            guard let result = result else {
                completion(Planet(name: "n/a"), error)
                return
            }
                        
            guard let planet = Planet(json: result) else {
                completion(Planet(name: "n/a"), .jsonParsingFailure(messege: "results do not line up with planet class"))
                return
            }
            
            completion(planet, nil)
        }
    }
    
    
    
    
    typealias Results = [[String: Any]]
    typealias Result = [String: Any]
    
    // MARK: Preform Request
    private func preformRequest(with endpoint: Endpoint, completion: @escaping(Results?, StarwarsError?) -> Void) {
        
        // Create the task with the endpoint provided...
        let task = downloader.jsonTask(with: endpoint.request) {json, error in
            
            // Create the task in the background...
            DispatchQueue.main.async {
                guard let json = json else {
                    completion(nil, error)
                    return
                }
                
                guard let results = json["results"] as? Results else {
                    completion(nil, .jsonParsingFailure(messege: "JSON data does not contain results"))
                    return
                }
                
                completion(results, nil)
            }
        }
        
        task.resume()
    }
    
    private func preformSingleRequest(with endpoint: Endpoint, completion: @escaping(Result?, StarwarsError?) -> Void) {
        
        let task = downloader.jsonTask(with: endpoint.request) {json, error in
            
            // Create the task in the background
            DispatchQueue.main.async {
                guard let json = json else {
                    completion(nil, error)
                    return
                }
                
                guard let results = json as? Result else {
                    completion(nil, .jsonParsingFailure(messege: "JSON data does not contain results"))
                    return
                }
                
                completion(results, nil)
            }
        }
        
        task.resume()
    }
}
