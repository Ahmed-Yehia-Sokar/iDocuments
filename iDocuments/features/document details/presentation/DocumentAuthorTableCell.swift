//
//  DocumentAuthorTableCell.swift
//  iDocuments
//
//  Created by admin on 22/12/2022.
//

import UIKit

class DocumentAuthorTableCell: UITableViewCell {
    // MARK: - IBOutlets
    
    @IBOutlet weak var documentAuthorLabel: UILabel!
    
    // MARK: - public methods
    
    func configureCell(withAuthor author: String) {
        documentAuthorLabel.text = author
    }
}
