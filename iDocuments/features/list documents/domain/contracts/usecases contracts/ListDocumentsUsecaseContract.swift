//
//  ListDocumentsUsecaseContract.swift
//  iDocuments
//
//  Created by admin on 18/12/2022.
//

import Foundation

protocol ListDocumentsUsecaseContract {
    func listDocuments(forQuery query: String,
                       page: Int,
                       completionHandler: @escaping ([Document]) -> Void,
                       errorHandler: @escaping (String) -> Void)
    
    func listDocuments(forTitle title: String,
                      page: Int,
                      completionHandler: @escaping ([Document]) -> Void,
                      errorHandler: @escaping (String) -> Void)
    
    func listDocuments(forAuthor author: String,
                      page: Int,
                      completionHandler: @escaping ([Document]) -> Void,
                      errorHandler: @escaping (String) -> Void)
}
