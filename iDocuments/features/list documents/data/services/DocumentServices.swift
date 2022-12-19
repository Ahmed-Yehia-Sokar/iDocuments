//
//  DocumentServices.swift
//  iDocuments
//
//  Created by admin on 18/12/2022.
//

import Foundation
import Alamofire

class DocumentServices: DocumentServicesContract {
    // MARK: - properties
    
    private let webserviceManager: WebserviceManager
    private var getDocumentsCompletionHandler: (([Document]) -> Void)?
    private var getDocumentsErrorHandler: ((String) -> Void)?

    // MARK: - public methods
    
    init(webserviceManager: WebserviceManager) {
        self.webserviceManager = webserviceManager
    }
    
    func getDocuments(forQuery query: String,
                      page: Int,
                      completionHandler: @escaping ([Document]) -> Void,
                      errorHandler: @escaping (String) -> Void) {
        getDocumentsCompletionHandler = completionHandler
        getDocumentsErrorHandler = errorHandler
        
        let parameters: Parameters = [
            "q": query,
            "page": page
        ]
        
        webserviceManager.callWebservice(webserviceUrl: WebserviceUrl.searchQuery,
                                         parameters: parameters,
                                         successHandler: getDocumentsSuccessHandler,
                                         errorHandler: getDocumentsErrorHandler)
    }
    
    // MARK: - private methods
    
    private func getDocumentsSuccessHandler(response: Any) {
        let documentsList = DocumentDataMapper.map(response: response)

        getDocumentsCompletionHandler?(documentsList)
    }
    
    private func getDocumentsErrorHandler(errorDictionary: [String: Any]) {
        var errorMessage = "Oops! Something went wrong!"
        if let errorMessageFromResponse = errorDictionary["description"] as? String {
            errorMessage = errorMessageFromResponse
        }
        
        getDocumentsErrorHandler?(errorMessage)
    }
}
