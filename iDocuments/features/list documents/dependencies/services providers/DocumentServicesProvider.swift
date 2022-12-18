//
//  DocumentServicesProvider.swift
//  iDocuments
//
//  Created by admin on 18/12/2022.
//

import Foundation

class DocumentServicesProvider {
    // MARK: - methods
    
    static func getDocumentServices() -> DocumentServices {
        let webserviceManager = WebserviceManager()
        
        return DocumentServices(webserviceManager: webserviceManager)
    }
}
