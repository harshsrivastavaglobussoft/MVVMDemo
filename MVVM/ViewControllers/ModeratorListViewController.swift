//
//  ModeratorListViewController.swift
//  MVVM
//
//  Created by Sumit Ghosh on 09/07/18.
//  Copyright © 2018 Sumit Ghosh. All rights reserved.
//

import UIKit

class ModeratorListViewController: UIViewController ,AlertDisplayer {
    
    private enum CallIdentifiers {
        static let list = "List"
    }

    @IBOutlet weak var ModeratorTableView: UITableView!
    @IBOutlet weak var indicatorView: UIActivityIndicatorView!
    
    
    var site: String!
    private var viewModel: ModeratorsViewModel!
    private var shouldShowLoadingCell = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        indicatorView.startAnimating()
        
        ModeratorTableView.isHidden = true
        ModeratorTableView.separatorColor = ColorPalette.RWGreen
        ModeratorTableView.dataSource = self
        ModeratorTableView.prefetchDataSource = self
        
        let requesr = ModeratorRequest.from(site: site)
        viewModel = ModeratorsViewModel.init(request: requesr, delegate: self)
        viewModel.fetchModerators()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension ModeratorListViewController: UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.totalCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CallIdentifiers.list, for: indexPath) as! ModeratorTableViewCell
        
        if isLoadingCell(for: indexPath) {
            cell.configure(with: .none)
        } else {
            cell.configure(with: viewModel.moderator(at: indexPath.row))
        }
        return cell
    }
    
}

extension ModeratorListViewController: UITableViewDataSourcePrefetching {
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        if indexPaths.contains(where: isLoadingCell) {
            viewModel.fetchModerators()
        }
    }
}

extension ModeratorListViewController: ModeratorsViewModelDelegate {
    func onFetchFailed(with reason: String) {
        indicatorView.stopAnimating()
        let title = "Warning".localizedString
        let action = UIAlertAction.init(title: "OK".localizedString, style: .default)
        displayAlert(with: title, message: reason, actions: [action])
    }
    
    func onFetchCompleted(with newIndexPathToReload: [IndexPath]?) {
     
        guard let newIndexPathsToReload = newIndexPathToReload else {
            indicatorView.stopAnimating()
            ModeratorTableView.isHidden = false
            ModeratorTableView.reloadData()
            return
        }

        let indexPathsToReload = visibleIndexPathsToReload(intersecting: newIndexPathsToReload)
        ModeratorTableView.reloadRows(at: indexPathsToReload, with: .automatic)
    }
}

private extension ModeratorListViewController {
    func isLoadingCell(for indexPath: IndexPath) -> Bool {
        return indexPath.row >= viewModel.currentCount
    }
    
    func visibleIndexPathsToReload(intersecting indexPaths: [IndexPath]) -> [IndexPath] {
        let indexPathsForVisibleRows = ModeratorTableView.indexPathsForVisibleRows ?? []
        let indexPathsIntersection = Set(indexPathsForVisibleRows).intersection(indexPaths)
        return Array(indexPathsIntersection)
    }
}
