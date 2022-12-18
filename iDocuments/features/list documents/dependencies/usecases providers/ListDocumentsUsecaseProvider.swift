//
//  ListDocumentsUsecaseProvider.swift
//  iDocuments
//
//  Created by admin on 19/12/2022.
//

import Foundation

class ListDocumentsUsecaseProvider {
    // MARK: - methods
    
    static func getListDocumentsUsecase() -> ListDocumentsUsecase {
        let documentServices = DocumentServicesProvider.getDocumentServices()
        
        return ListDocumentsUsecase(documentServices: documentServices)
    }
}
