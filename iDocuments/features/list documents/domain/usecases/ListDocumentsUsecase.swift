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
    
    func listDocuments(forTitle title: String,
                       page: Int,
                       completionHandler: @escaping ([Document]) -> Void,
                       errorHandler: @escaping (String) -> Void) {
        documentServices.getDocuments(forTitle: title,
                                      page: page,
                                      completionHandler: completionHandler,
                                      errorHandler: errorHandler)
    }
    
    func listDocuments(forAuthor author: String,
                       page: Int,
                       completionHandler: @escaping ([Document]) -> Void,
                       errorHandler: @escaping (String) -> Void) {
        documentServices.getDocuments(forAuthor: author,
                                      page: page,
                                      completionHandler: completionHandler,
                                      errorHandler: errorHandler)
    }
}
