//
//  DocumentCoverTableCell.swift
//  iDocuments
//
//  Created by admin on 22/12/2022.
//

import UIKit
import AlamofireImage

class DocumentCoverTableCell: UITableViewCell {
    // MARK: - IBOutlets

    @IBOutlet weak var documentCoverImageView: UIImageView!
    @IBOutlet weak var isbnLabel: UILabel!
    
    // MARK: - public methods
    
    func configureCell(withISBN isbnURL: URL? = nil, isbn: String) {
        if let isbnURL = isbnURL {
            documentCoverImageView.af.setImage(withURL: isbnURL,
                                               cacheKey: isbn,
                                               placeholderImage: UIImage(named: "Image-not-found"))
        }
        
        isbnLabel.text = isbn
    }
}
