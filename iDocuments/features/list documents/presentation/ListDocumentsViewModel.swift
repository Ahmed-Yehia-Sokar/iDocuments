//
//  ListDocumentsViewModel.swift
//  iDocuments
//
//  Created by admin on 18/12/2022.
//

import Foundation

class ListDocumentsViewModel {
    // MARK: - properties
    
    private(set) var documentsList = Bindable<[Document]>()
    private var currentPage = 1
    private let listDocumentsUsecase: ListDocumentsUsecaseContract
    
    // MARK: - public methods
    
    init(listDocumentsUsecase: ListDocumentsUsecaseContract) {
        self.listDocumentsUsecase = listDocumentsUsecase
    }
    
    func listDocuments(forQuery query: String,
                       inquireNextPage: Bool = false,
                       errorHandler: @escaping (String) -> Void) {
        if inquireNextPage {
            currentPage += 1
        }
        
        listDocumentsUsecase.listDocuments(forQuery: query,
                                           page: currentPage) { newDocumentsList in
            var updatedDocumentsList = self.documentsList.value ?? []
            
            updatedDocumentsList.append(contentsOf: newDocumentsList)
            self.documentsList.value = updatedDocumentsList
        } errorHandler: { errorMessage in
            errorHandler(errorMessage)
        }
    }
    
    func resetCurrentPage() {
        currentPage = 1
    }
    
    func makeDocumentsListEmpty() {
        self.documentsList.value?.removeAll()
    }
}
