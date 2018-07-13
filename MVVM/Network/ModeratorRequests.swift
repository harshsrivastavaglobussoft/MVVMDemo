//
//  ModeratorRequests.swift
//  MVVM
//
//  Created by Sumit Ghosh on 10/07/18.
//  Copyright © 2018 Sumit Ghosh. All rights reserved.
//

import Foundation

struct ModeratorRequest {
    var path: String {
        return "users/moderators"
    }

let parameters: Parameters
    private init(parameters: Parameters) {
        self.parameters = parameters
    }
}

extension ModeratorRequest {
    static func from(site: String) -> ModeratorRequest {
        let defaultParameters = ["order": "desc", "sort": "reputation", "filter":"!-jbN0CeyJHb"]
        let parameters = ["site": "\(site)"].merging(defaultParameters, uniquingKeysWith: +)
        return ModeratorRequest(parameters: parameters)
    }
}
