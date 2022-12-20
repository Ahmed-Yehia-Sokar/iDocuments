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
        var result = [Document]()
        guard let responseAsDic = response as? [String: Any],
              let docsList = responseAsDic.getArray("docs") as? [[String: Any]] else {
            return result
        }
        
        for doc in docsList {
            let title = doc.getString("title_suggest")
            let authorNamesList = doc.getArray("author_name") as? [String]
            let isbnsList = (doc.getArray("isbn") as? [String]) ?? []
            let firstAuthorName = authorNamesList?.first(where: { $0 != "" }) ?? ""
            let firstFiveISBNsList = Array(isbnsList.prefix(5))
            let document = Document(title: title,
                                    author: firstAuthorName,
                                    isbnsList: firstFiveISBNsList)
            
            result.append(document)
        }
        
        return result
    }
}
