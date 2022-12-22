//
//  DocumentTitleTableCell.swift
//  iDocuments
//
//  Created by admin on 22/12/2022.
//

import UIKit

class DocumentTitleTableCell: UITableViewCell {
    // MARK: - IBOutlets
    
    @IBOutlet weak var documentTitleLabel: UILabel!
    
    // MARK: - public methods
    
    func configureCell(withTitle title: String) {
        documentTitleLabel.text = title
    }
}
