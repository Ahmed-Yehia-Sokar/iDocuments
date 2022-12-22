//
//  DocumentDataMapper.swift
//  iDocuments
//
//  Created by admin on 18/12/2022.
//

import Foundation

fileprivate enum CoverImageSize: String {
    case small = "-S.jpg"
    case meduim = "-M.jpg"
    case large = "-L.jpg"
}

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
            var isbnsList = (doc.getArray("isbn") as? [String]) ?? []
            let firstAuthorName = authorNamesList?.first(where: { $0 != "" }) ?? ""
            
            if isbnsList.count > 5 {
                isbnsList = Array(isbnsList.prefix(5))
            }
            
            let coverURLsList = isbnsList.map { isbn in
                WebserviceUrl.coverURL + isbn + CoverImageSize.meduim.rawValue
            }
            let document = Document(title: title,
                                    author: firstAuthorName,
                                    isbnsList: isbnsList,
                                    coverURLsList: coverURLsList)
            
            result.append(document)
        }
        
        return result
    }
}
