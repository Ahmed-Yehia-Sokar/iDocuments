//
//  WebserviceUrl.swift
//  iDocuments
//
//  Created by admin on 18/12/2022.
//

import Foundation

fileprivate struct WebServiceSource {
    static let baseURL = "https://openlibrary.org"
    static let couverBaseURL = "https://covers.openlibrary.org/b/isbn"
}

struct WebserviceUrl {
    static let searchQuery = "\(WebServiceSource.baseURL)/search.json?"
    static let coverURL = "\(WebServiceSource.couverBaseURL)/"
}
