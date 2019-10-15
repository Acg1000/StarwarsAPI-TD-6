//
//  ConversionRatioError.swift
//  StarwarsAPI-TD-6
//
//  Created by Andrew Graves on 10/10/19.
//  Copyright © 2019 Andrew Graves. All rights reserved.
//
//  Function: Create the error type when there is a conversion issue

import Foundation

enum ConversionRatioError: Error {
    case invalidEntry
    case missingEntry
}
