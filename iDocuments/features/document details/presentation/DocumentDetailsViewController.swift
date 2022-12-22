//
//  DocumentDetailsViewController.swift
//  iDocuments
//
//  Created by admin on 22/12/2022.
//

import UIKit

class DocumentDetailsViewController: UIViewController {
    // MARK: - IBOutlets
    
    // MARK: - properties
    
    private var documentDetailsViewModel: DocumentDetailsViewModel?
    
    // MARK: - public methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func initViewController(withViewModel documentDetailsViewModel: DocumentDetailsViewModel) {
        self.documentDetailsViewModel = documentDetailsViewModel
    }
}

extension DocumentDetailsViewController: UITableViewDelegate {

}

extension DocumentDetailsViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        3
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Document Name"
        } else if section == 1 {
            return "Document Author"
        }
        return "Document Covers"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 || section == 1 {
            return 1
        }
        return documentDetailsViewModel?.selectedDocument.coverURLsList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 || indexPath.section == 1 {
            return 70.0
        }
        return 250.0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentTitleTableCell", for: indexPath) as? DocumentTitleTableCell else {
                return DocumentTitleTableCell()
            }
            
            cell.configureCell(withTitle: documentDetailsViewModel?.selectedDocument.title ?? "")
            return cell
        } else if indexPath.section == 1 {
            guard let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentAuthorTableCell", for: indexPath) as? DocumentAuthorTableCell else {
                return DocumentAuthorTableCell()
            }
            
            cell.configureCell(withAuthor: documentDetailsViewModel?.selectedDocument.author ?? "")
            return cell
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "DocumentCoverTableCell", for: indexPath) as? DocumentCoverTableCell else {
            return DocumentCoverTableCell()
        }
         
        if let documentDetailsViewModel = documentDetailsViewModel {
            cell.configureCell(withISBN: documentDetailsViewModel.getISBNURL(indexPath: indexPath),
                               isbn: documentDetailsViewModel.getISBN(indexPath: indexPath))
        }
        
        return cell
    }
}
