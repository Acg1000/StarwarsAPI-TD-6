//
//  JSONDownloader.swift
//  StarwarsAPI-TD-6
//
//  Created by Andrew Graves on 8/25/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//
// Function: Download the JSON and parse errors if there is a problem with any connection on either side

import Foundation

class JSONDownloader {
    let session: URLSession
    
    init(configuration: URLSessionConfiguration) {
        self.session = URLSession(configuration: configuration)
    }
    
    convenience init() {
        self.init(configuration: .default)
    }
    
    typealias JSONTaskCompletionHandler = (Data?, StarwarsError?) -> Void
    
    func jsonTask(with request: URLRequest, completionHandler completion: @escaping JSONTaskCompletionHandler) -> URLSessionDataTask {
        let task = session.dataTask(with: request) { data, response, error in
            
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(nil, .requestFailed)
                return
            }
            
            // Depending on the status code...
            if httpResponse.statusCode == 200 {
                if let data = data {
                    
                    let json = data
                    completion(json, nil)
                    
                } else {
                    completion(nil, .invalidData)
                }
            } else {
                completion(nil, .responseUnsuccessful)
            }
            
        }
        
        return task
    }
}
