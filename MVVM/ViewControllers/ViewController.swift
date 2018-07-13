//
//  ViewController.swift
//  MVVM
//
//  Created by Sumit Ghosh on 09/07/18.
//  Copyright © 2018 Sumit Ghosh. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    private enum SegueIdentifiers {
        static let list = "ListViewController"
    }
    @IBOutlet weak var moderatorTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    private var behavior: ButtonEnablingBehavior!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = NSLocalizedString("Search", comment: "")
        
        behavior = ButtonEnablingBehavior.init(textFields: [moderatorTextField]) {
            [unowned self] enable in
            
            if enable {
                self.searchButton.isEnabled = true
                self.searchButton.alpha = 1
            } else {
                self.searchButton.isEnabled = false
                self.searchButton.alpha = 0.7
            }
        }
        
        moderatorTextField.setBottomBorder()
    }

    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == SegueIdentifiers.list {
            if let listViewController = segue.destination as? ModeratorListViewController {
                listViewController.site = moderatorTextField.text!
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

