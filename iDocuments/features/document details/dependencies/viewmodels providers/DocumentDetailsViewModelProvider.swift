//
//  DocumentDetailsViewModelProvider.swift
//  iDocuments
//
//  Created by admin on 22/12/2022.
//

import Foundation

class DocumentDetailsViewModelProvider {
    // MARK: - methods
    
    static func getDocumentDetailsViewModel(withDocument selectedDocument: Document) -> DocumentDetailsViewModel {
        return DocumentDetailsViewModel(selectedDocument: selectedDocument)
    }
}
