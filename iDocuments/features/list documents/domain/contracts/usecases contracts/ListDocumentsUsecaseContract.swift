//
//  ListDocumentsUsecaseContract.swift
//  iDocuments
//
//  Created by admin on 18/12/2022.
//

import Foundation

protocol ListDocumentsUsecaseContract {
    func listDocuments(forQuery query: String,
                       completionHandler: @escaping ([Document]) -> Void,
                       errorHandler: @escaping (String) -> Void)
}
