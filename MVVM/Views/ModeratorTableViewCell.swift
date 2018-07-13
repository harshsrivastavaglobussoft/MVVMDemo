//
//  ModeratorTableViewCell.swift
//  MVVM
//
//  Created by Sumit Ghosh on 09/07/18.
//  Copyright © 2018 Sumit Ghosh. All rights reserved.
//

import UIKit

class ModeratorTableViewCell: UITableViewCell {

    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var ReputationLabel: UILabel!
    @IBOutlet weak var moderatorLabel: UILabel!
    @IBOutlet weak var reputationContainerView: UIView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        configure(with: .none)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        reputationContainerView.backgroundColor = UIColor.lightGray
        reputationContainerView.layer.cornerRadius = 6
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.color = ColorPalette.RWGreen
    }
    
    func configure(with moderator: Moderator?) -> Void {
        if let moderator = moderator {
            moderatorLabel.text = moderator.displayName
            ReputationLabel.text = moderator.reputation
            moderatorLabel.alpha = 1
            reputationContainerView.alpha = 1
            activityIndicator.stopAnimating()
        }else{
            moderatorLabel.alpha = 0
            ReputationLabel.alpha = 0
            activityIndicator.startAnimating()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
