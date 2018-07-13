//
//  UITextField+Extensions.swift
//  MVVM
//
//  Created by Sumit Ghosh on 13/07/18.
//  Copyright © 2018 Sumit Ghosh. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func setBottomBorder() -> Void {
        borderStyle = .none
        layer.backgroundColor = UIColor.white.cgColor
        layer.masksToBounds = false
        layer.shadowColor = ColorPalette.RWGreen.cgColor
        layer.shadowOffset = CGSize(width: 0.0, height: 1.0)
        layer.shadowOpacity = 1.0
        layer.shadowRadius = 0.0
    }
}
