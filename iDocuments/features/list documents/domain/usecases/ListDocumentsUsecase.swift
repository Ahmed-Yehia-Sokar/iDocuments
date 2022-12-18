//
//  ListDocumentsUsecase.swift
//  iDocuments
//
//  Created by admin on 18/12/2022.
//

import Foundation

class ListDocumentsUsecase: ListDocumentsUsecaseContract {
    // MARK: - properties
    
    private let documentServices: DocumentServicesContract
    private var currentPage = 0
    
    // MARK: - public methods
    
    init(documentServices: DocumentServicesContract) {
        self.documentServices = documentServices
    }
    
    func listDocuments(forQuery query: String,
                       completionHandler: @escaping ([Document]) -> Void,
                       errorHandler: @escaping (String) -> Void) {
        currentPage += 1
        
        documentServices.getDocuments(forQuery: query,
                                      page: currentPage,
                                      completionHandler: completionHandler,
                                      errorHandler: errorHandler)
    }
}
