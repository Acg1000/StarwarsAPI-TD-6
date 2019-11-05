//
//  Result.swift
//  StarwarsAPI-TD-6
//
//  Created by Andrew Graves on 10/26/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//

import Foundation

struct Result<T>: Codable where T: Codable {
    let count: Int
    let next: URL?
    let previous: URL?
    let results: [T]
    
}


