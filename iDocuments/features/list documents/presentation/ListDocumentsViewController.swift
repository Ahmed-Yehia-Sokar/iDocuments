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
    
    // MARK: - public methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(searchByTitleHandler),
                                               name: NotificationName.searchByTitle,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(searchByAuthorHandler),
                                               name: NotificationName.searchByAuthor,
                                               object: nil)
        
        activityIndicatorView.isHidden = true

        listDocumentsViewModel.documentsList.bind { [weak self] documentsList in
            guard let unwrappedSelf = self else { return }
            if let documentsList = documentsList,
               documentsList.isEmpty {
                unwrappedSelf.emptyView.isHidden = false
            } else {
                unwrappedSelf.activityIndicatorView.isHidden = true
                unwrappedSelf.emptyView.isHidden = true
                unwrappedSelf.activityIndicatorView.stopAnimating()
                unwrappedSelf.tableView.reloadData()
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: false)
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
    
    @objc private func searchByTitleHandler() {
        if listDocumentsViewModel.isSelectedDocumentTitleValid() {
            searchBar.text = listDocumentsViewModel.returnSelectedDocumentTitle()
            activityIndicatorView.isHidden = false
            activityIndicatorView.startAnimating()
            listDocumentsViewModel.resetPagination()
            
            listDocumentsViewModel.listDocuments(forTitle: listDocumentsViewModel.returnSelectedDocumentTitle(),
                                                 errorHandler: listDocumentsErrorHandler)
        }
    }
    
    @objc private func searchByAuthorHandler() {
        if listDocumentsViewModel.isSelectedDocumentAuthorValid() {
            searchBar.text = listDocumentsViewModel.returnSelectedDocumentAuthor()
            activityIndicatorView.isHidden = false
            activityIndicatorView.startAnimating()
            listDocumentsViewModel.resetPagination()
            
            listDocumentsViewModel.listDocuments(forAuthor: listDocumentsViewModel.returnSelectedDocumentAuthor(),
                                                errorHandler: listDocumentsErrorHandler)
        }
    }
}

extension ListDocumentsViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText.isEmpty {
            listDocumentsViewModel.resetSearchForSpecificTitle()
            listDocumentsViewModel.resetSearchForSpecificAuthor()
            listDocumentsViewModel.resetPagination()
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectedDocument = listDocumentsViewModel.getDocument(atIndexPath: indexPath) {
            listDocumentsViewModel.setSelectedDocument(selectedDocument: selectedDocument)
            
            if let documentDetailsVC = storyboard?.instantiateViewController(withIdentifier: "DocumentDetailsViewController") as? DocumentDetailsViewController {
                let documentDetailsVM = DocumentDetailsViewModelProvider.getDocumentDetailsViewModel(withDocument: selectedDocument)
                
                documentDetailsVC.initViewController(withViewModel: documentDetailsVM)
                navigationController?.pushViewController(documentDetailsVC, animated: true)
            }
        }
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > (tableView.contentSize.height - 50) - (scrollView.frame.size.height) {
            guard let searchText = searchBar.text else { return }
            guard !listDocumentsViewModel.isPaginationOn else { return }
            
            if listDocumentsViewModel.searchForSpecificTitle {
                listDocumentsViewModel.listDocuments(forTitle: searchText,
                                                     isPaginationOn: true,
                                                     errorHandler: listDocumentsErrorHandler)
            } else if listDocumentsViewModel.searchForSpecificAuthor {
                listDocumentsViewModel.listDocuments(forAuthor: searchText,
                                                     isPaginationOn: true,
                                                     errorHandler: listDocumentsErrorHandler)
            } else {
                listDocumentsViewModel.listDocuments(forQuery: searchText,
                                                     isPaginationOn: true,
                                                     errorHandler: listDocumentsErrorHandler)
            }
        }
    }
}

extension ListDocumentsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        listDocumentsViewModel.getDocumentsCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentTableCell", for: indexPath) as? DocumentTableCell,
              let document = listDocumentsViewModel.getDocument(atIndexPath: indexPath) else {
            return DocumentTableCell()
        }
        
        cell.configureCell(withTitle: document.title,
                           author: document.author)
        return cell
    }
}
