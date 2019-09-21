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
                print("ERROR WITH RESULTS: Endpoint: \(endpoint.base + endpoint.path)")
                completion([], error)
                return
            }
                        
            let characters = results.compactMap { Character(json: $0) }
//            print("characters: \(characters)")
            
            completion(characters, nil)
        }
    }
    
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
        
        let endpoint1 = Starwars.planets(id: id)
        print("Looking up planet: \(endpoint1.request)")

        
        preformRequest(with: endpoint1) { results, error in
            guard let results = results else {
                print("ERRORrr WITH RESULTS: Endpoint: -\(endpoint1)-")
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
