//
//  Object.swift
//  StarwarsAPI-TD-6
//
//  Created by Andrew Graves on 9/23/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//
//  Function: Create a protocol that all objects have to conform to what makes it possible to assign their information to each cell in the tableview.

import Foundation

protocol Object {
    var type: StarwarsResource { get }
    
    var title: String { get }
    var sizeAttribute: Double { get }
    
    var attribute1: String { get }
    var attribute2: String { get set }
    var attribute3: String { get }
    var attribute4: String { get }
    var attribute5: String { get }
    
}
