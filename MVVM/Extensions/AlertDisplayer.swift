//
//  AlertDisplayer.swift
//  MVVM
//
//  Created by Sumit Ghosh on 13/07/18.
//  Copyright © 2018 Sumit Ghosh. All rights reserved.
//

import Foundation
import UIKit

protocol AlertDisplayer {
    func displayAlert(with title: String,message: String, actions:[UIAlertAction]?)
}

extension AlertDisplayer where Self: UIViewController {
    func displayAlert(with title: String, message: String, actions: [UIAlertAction]? = nil) {
        guard presentedViewController == nil else {
            return
        }
    
    let alertController = UIAlertController.init(title: title, message: message, preferredStyle: .alert)
        actions?.forEach { actions in
            alertController.addAction(actions)
        }
        present(alertController, animated: true)
    }
}
