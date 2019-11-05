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
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        // Call the preform request function with the URL / endpoint that wejust created
        preformRequest(with: endpoint) { json, error in
            
            // When we get results back...
            guard let json = json else {
                // If the json is nill pass an error through the completion handler
                completion([], error)
                return
            }
            
            
            do {
                
                let results = try decoder.decode(Result<Character>.self, from: json)
                let characters = results.results
                
                for character in characters {
                    self.lookupPlanet(withURL: character.attribute2) { planet, error in
                        print(character.attribute2)
                        print(planet.name)
                        character.attribute2 = planet.name
                        
                        completion(characters, nil)

                    }
                }
                
                print(characters)
                completion(characters, nil)
                
                
            } catch {
                print("Error with Decoded Character Results \(error)")
                fatalError("\(error)")
            }
        }
    }
    
    // MARK: getVehicles
    
    // get vehicles method
    func getVehicles(completion: @escaping ([Vehicle], StarwarsError?) -> Void) {
        
        // Create the endpoint and pass nil because we want all the characters
        let endpoint = Starwars.vehicles(id: nil)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        // Call the preform request function with the URL / endpoint that wejust created
        preformRequest(with: endpoint) { json, error in
            
            // When we get results back, check to see if the json is present
            guard let json = json else {
                completion([], error)
                return
            }
            
            // If it is then try to decode it to the Result Data Structure
            do {
                
                let results = try decoder.decode(Result<Vehicle>.self, from: json)
                let vehicles = results.results
                
                print(vehicles)
                completion(vehicles, nil)
                
                
            } catch {
                print("Error with Decoded Character Results \(error)")
                fatalError("\(error)")
            }
        }
    }
    
    // MARK: getStarships
    
    // get starships method
    func getStarships(completion: @escaping ([Starship], StarwarsError?) -> Void) {
        
        // Create the endpoint and pass nil because we want all the characters
        let endpoint = Starwars.starships(id: nil)
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        // Call the preform request function with the URL / endpoint that wejust created
        preformRequest(with: endpoint) { json, error in
            
            // When we get results back, check to see if the json is present
            guard let json = json else {
                completion([], error)
                return
            }
            
            // If it is then try to decode it to the Result Data Structure
            do {
                
                let results = try decoder.decode(Result<Starship>.self, from: json)
                let starships = results.results
                
                print(starships)
                completion(starships, nil)
                
                
            } catch {
                print("Error with Decoded Character Results \(error)")
                fatalError("\(error)")
            }
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
            
            let decoder = JSONDecoder()

            guard let result = result else {
                completion(Planet(), error)
                return
            }
            
            do {
                let planet = try decoder.decode(Planet.self, from: result)

                completion(planet, nil)

            } catch {
                
                print("Error with Decoded Planet Results \(error)")
                fatalError("\(error)")
            }
        }
    }
    
    
    // MARK: Preform Request
    private func preformRequest(with endpoint: Endpoint, completion: @escaping(Data?, StarwarsError?) -> Void) {
        
        // Create the task with the endpoint provided...
        let task = downloader.jsonTask(with: endpoint.request) {json, error in
                        
            // Create the task in the background...
            DispatchQueue.main.async {
                guard let json = json else {
//                    fatalError("\(error)")
                    completion(nil, error)
                    return
                }
                
                completion(json, nil)
                
            }
        }
        
        task.resume()
    }
    
    private func preformSingleRequest(with endpoint: Endpoint, completion: @escaping(Data?, StarwarsError?) -> Void) {
        
        let task = downloader.jsonTask(with: endpoint.request) {json, error in
            
            // Create the task in the background
            DispatchQueue.main.async {
                guard let json = json else {
//                    fatalError("Single Request Error... \(error)")
                    completion(nil, error)
                    return
                }
                
                completion(json, nil)
            }
        }
        
        task.resume()
    }
}
