//
//  WebserviceUrl.swift
//  iDocuments
//
//  Created by admin on 18/12/2022.
//

import Foundation

fileprivate struct WebServiceSource {
    static let baseURL = "https://openlibrary.org"
}

struct WebserviceUrl {
    static let searchQuery = "\(WebServiceSource.baseURL)/search.json?"
    static let searchForTitle = "\(WebServiceSource.baseURL)/search.json?title="
    static let searchForAuthor = "\(WebServiceSource.baseURL)/search.json?author="
}
