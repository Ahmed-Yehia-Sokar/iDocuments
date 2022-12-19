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
    
    // MARK: - public methods
    
    init(documentServices: DocumentServicesContract) {
        self.documentServices = documentServices
    }
    
    func listDocuments(forQuery query: String,
                       page: Int = 1,
                       completionHandler: @escaping ([Document]) -> Void,
                       errorHandler: @escaping (String) -> Void) {
        documentServices.getDocuments(forQuery: query,
                                      page: page,
                                      completionHandler: completionHandler,
                                      errorHandler: errorHandler)
    }
}
