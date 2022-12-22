//
//  ListDocumentsViewModel.swift
//  iDocuments
//
//  Created by admin on 18/12/2022.
//

import Foundation

class ListDocumentsViewModel {
    // MARK: - properties
    
    private let listDocumentsUsecase: ListDocumentsUsecaseContract
    private var currentPage = 1
    private(set) var isPaginationOn = false
    private(set) var documentsList = Bindable<[Document]>()
    
    // MARK: - public methods
    
    init(listDocumentsUsecase: ListDocumentsUsecaseContract) {
        self.listDocumentsUsecase = listDocumentsUsecase
    }
    
    func listDocuments(forQuery query: String,
                       isPaginationOn: Bool = false,
                       errorHandler: @escaping (String) -> Void) {
        if isPaginationOn {
            currentPage += 1
            self.isPaginationOn = true
        }
        
        listDocumentsUsecase.listDocuments(forQuery: query,
                                           page: currentPage) { [weak self] newDocumentsList in
            guard let unwrappedSelf = self else { return }
            var updatedDocumentsList = unwrappedSelf.documentsList.value ?? []
            
            updatedDocumentsList.append(contentsOf: newDocumentsList)
            unwrappedSelf.documentsList.value = updatedDocumentsList
            unwrappedSelf.isPaginationOn = false
        } errorHandler: { errorMessage in
            errorHandler(errorMessage)
        }
    }
    
    func resetPagination() {
        currentPage = 1
        isPaginationOn = false
        documentsList.value?.removeAll()
    }
    
    func getDocument(atIndexPath indexPath: IndexPath) -> Document? {
        documentsList.value?[indexPath.row]
    }
    
    func getDocumentsCount() -> Int {
        documentsList.value?.count ?? 0
    }
}
