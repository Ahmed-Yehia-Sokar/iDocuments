//
//  ListDocumentsViewModelProvider.swift
//  iDocuments
//
//  Created by admin on 19/12/2022.
//

import Foundation

class ListDocumentsViewModelProvider {
    // MARK: - methods
    
    static func getListDocumentsViewModel() -> ListDocumentsViewModel {
        let listDocumentsUsecase = ListDocumentsUsecaseProvider.getListDocumentsUsecase()
        
        return ListDocumentsViewModel(listDocumentsUsecase: listDocumentsUsecase)
    }
}
