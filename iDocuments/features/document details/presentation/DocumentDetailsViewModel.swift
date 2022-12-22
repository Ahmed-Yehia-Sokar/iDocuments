//
//  DocumentDetailsViewModel.swift
//  iDocuments
//
//  Created by admin on 22/12/2022.
//

import Foundation

class DocumentDetailsViewModel {
    // MARK: - properties
    
    let selectedDocument: Document
    
    // MARK: - methods
    
    init(selectedDocument: Document) {
        self.selectedDocument = selectedDocument
    }
    
    func getISBNURL(indexPath: IndexPath) -> URL? {
        if selectedDocument.coverURLsList.isEmpty {
            return nil
        }
        
        if let isbnURL = URL(string: selectedDocument.coverURLsList[indexPath.row]) {
            return isbnURL
        }
        return nil
    }
    
    func getISBN(indexPath: IndexPath) -> String {
        if selectedDocument.coverURLsList.isEmpty {
            return ""
        }
        return selectedDocument.isbnsList[indexPath.row]
    }
}
