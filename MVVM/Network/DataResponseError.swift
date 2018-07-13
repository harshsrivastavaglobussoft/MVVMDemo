//
//  DataResponseError.swift
//  MVVM
//
//  Created by Sumit Ghosh on 10/07/18.
//  Copyright © 2018 Sumit Ghosh. All rights reserved.
//

import Foundation
enum DataResponseError: Error {
    case network
    case decoding
    
    var reason: String {
        switch self {
        case .network:
            return "An error occurred while fetching data ".localizedString
        case .decoding:
            return "An error occurred while decoding data".localizedString
        }
    }
}
