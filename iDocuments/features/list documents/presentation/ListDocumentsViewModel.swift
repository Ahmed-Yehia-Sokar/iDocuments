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
    private(set) var selectedDocument: Document?
    private(set) var searchForSpecificTitle = false
    private(set) var searchForSpecificAuthor = false
    
    // MARK: - public methods
    
    init(listDocumentsUsecase: ListDocumentsUsecaseContract) {
        self.listDocumentsUsecase = listDocumentsUsecase
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(searchByTitleHandler),
                                               name: NotificationName.searchByTitle,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(searchByAuthorHandler),
                                               name: NotificationName.searchByAuthor,
                                               object: nil)
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
    
    func listDocuments(forTitle title: String,
                       isPaginationOn: Bool = false,
                       errorHandler: @escaping (String) -> Void) {
        if isPaginationOn {
            currentPage += 1
            self.isPaginationOn = true
        }
        
        listDocumentsUsecase.listDocuments(forTitle: title,
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
    
    func listDocuments(forAuthor author: String,
                       isPaginationOn: Bool = false,
                       errorHandler: @escaping (String) -> Void) {
        if isPaginationOn {
            currentPage += 1
            self.isPaginationOn = true
        }
        
        listDocumentsUsecase.listDocuments(forAuthor: author,
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
    
    func setSelectedDocument(selectedDocument: Document) {
        self.selectedDocument = selectedDocument
    }
    
    func returnSelectedDocumentTitle() -> String {
        if let selectedDocument = selectedDocument {
            return selectedDocument.title
        }
        return ""
    }
    
    func isSelectedDocumentTitleValid() -> Bool {
        if let selectedDocument = selectedDocument, !selectedDocument.title.isEmpty {
            return true
        }
        return false
    }
    
    func returnSelectedDocumentAuthor() -> String {
        if let selectedDocument = selectedDocument {
            return selectedDocument.author
        }
        return ""
    }
    
    func isSelectedDocumentAuthorValid() -> Bool {
        if let selectedDocument = selectedDocument, !selectedDocument.author.isEmpty {
            return true
        }
        return false
    }
    
    func resetSearchForSpecificTitle() {
        searchForSpecificTitle = false
    }
    
    func resetSearchForSpecificAuthor() {
        searchForSpecificAuthor = false
    }
    
    // MARK: - private methods
    
    @objc private func searchByTitleHandler() {
        searchForSpecificTitle = true
    }
    
    @objc private func searchByAuthorHandler() {
        searchForSpecificAuthor = true
    }
}
