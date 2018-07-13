//
//  Double+Extensions.swift
//  MVVM
//
//  Created by Sumit Ghosh on 10/07/18.
//  Copyright © 2018 Sumit Ghosh. All rights reserved.
//

import Foundation

extension Double {
    static let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = NumberFormatter.Style.decimal
        return formatter
    }()
    
    var formatted : String {
        return Double.formatter.string(for: self) ?? String(self)
    }
}
