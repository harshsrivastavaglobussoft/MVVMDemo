//
//  Result.swift
//  MVVM
//
//  Created by Sumit Ghosh on 10/07/18.
//  Copyright © 2018 Sumit Ghosh. All rights reserved.
//

import Foundation
enum Result<T, U: Error> {
    case success(T)
    case failure(U)
}
