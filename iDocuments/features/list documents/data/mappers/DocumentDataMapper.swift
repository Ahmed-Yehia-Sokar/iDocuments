//
//  DocumentDataMapper.swift
//  iDocuments
//
//  Created by admin on 18/12/2022.
//

import Foundation

class DocumentDataMapper {
    // MARK: - methods
    
    static func map(response: Any) -> [Document] {
        var documentsList = [Document]()
        guard let responseAsDic = response as? [String: Any],
              let docsList = responseAsDic["docs"] as? [[String: Any]] else {
            return documentsList
        }
        
        for doc in docsList {
            let title = (doc["title_suggest"] as? String) ?? ""
            let authorNamesList = (doc["author_name"] as? [String]) ?? []
            let firstAuthorName = authorNamesList.first ?? ""
            let isbnsList = (doc["isbn"] as? [String]) ?? []
            let firstFiveISBNsList = Array(isbnsList.prefix(5))
            let document = Document(title: title,
                                    author: firstAuthorName,
                                    isbnsList: firstFiveISBNsList)
            
            documentsList.append(document)
        }
        
        return documentsList
    }
}
