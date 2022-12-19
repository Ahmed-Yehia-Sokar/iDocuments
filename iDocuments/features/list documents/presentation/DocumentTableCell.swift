//
//  DocumentTableCell.swift
//  iDocuments
//
//  Created by admin on 19/12/2022.
//

import UIKit

class DocumentTableCell: UITableViewCell {
    // MARK: - IBOutlets
    
    @IBOutlet weak var documentTitleLabel: UILabel!
    @IBOutlet weak var documentAuthorLabel: UILabel!
    
    // MARK: - public methods
    
    func configureCell(withTitle title: String, author: String) {
        documentTitleLabel.text = title
        documentAuthorLabel.text = author
    }
}
