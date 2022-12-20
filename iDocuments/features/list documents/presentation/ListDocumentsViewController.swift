//
//  ListDocumentsViewController.swift
//  iDocuments
//
//  Created by admin on 18/12/2022.
//

import UIKit

class ListDocumentsViewController: UIViewController {
    // MARK: - IBOutlets
   
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var emptyView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicatorView: UIActivityIndicatorView!
    
    // MARK: - properties
    
    private let listDocumentsViewModel = ListDocumentsViewModelProvider.getListDocumentsViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicatorView.isHidden = true

        listDocumentsViewModel.documentsList.bind { documentsList in
            if let documentsList = documentsList,
               documentsList.isEmpty {
                self.emptyView.isHidden = false
            } else {
                self.activityIndicatorView.isHidden = true
                self.emptyView.isHidden = true
                self.activityIndicatorView.stopAnimating()
                self.tableView.reloadData()
            }
        }
    }
    
    // MARK: - private methods
    
    private func listDocumentsErrorHandler(errorMessage: String) {
        let alert = UIAlertController(title: "Error",
                                      message: errorMessage,
                                      preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok",
                                     style: .default,
                                     handler: nil)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
}

extension ListDocumentsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            listDocumentsViewModel.resetCurrentPage()
            listDocumentsViewModel.makeDocumentsListEmpty()
        }
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else { return }
        activityIndicatorView.isHidden = false
        activityIndicatorView.startAnimating()

        listDocumentsViewModel.listDocuments(forQuery: searchText,
                                             errorHandler: listDocumentsErrorHandler)
    }
}

extension ListDocumentsViewController: UITableViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > (tableView.contentSize.height - 50) - (scrollView.frame.size.height) {
            guard let searchText = searchBar.text else { return }
            guard !listDocumentsViewModel.isPaginationOn else { return }

            listDocumentsViewModel.listDocuments(forQuery: searchText,
                                                 isPaginationOn: true,
                                                 errorHandler: listDocumentsErrorHandler)
        }
    }
}

extension ListDocumentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listDocumentsViewModel.documentsList.value?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentTableCell", for: indexPath) as? DocumentTableCell,
              let document = listDocumentsViewModel.documentsList.value?[indexPath.row] else {
            return DocumentTableCell()
        }
        
        cell.configureCell(withTitle: document.title,
                           author: document.author)
        return cell
    }
}
