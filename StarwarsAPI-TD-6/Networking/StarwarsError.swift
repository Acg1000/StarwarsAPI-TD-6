//
//  StarwarsError.swift
//  StarwarsAPI-TD-6
//
//  Created by Andrew Graves on 8/25/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//
// Function: Provides cases of errors that can be used in error tracing and parsing

import Foundation

enum StarwarsError: Error {
    case requestFailed
    case jsonConversionFailure
    case invalidData
    case responseUnsuccessful
    case jsonParsingFailure(messege: String)
}
