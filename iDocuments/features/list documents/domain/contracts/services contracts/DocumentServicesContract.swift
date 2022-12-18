//
//  DocumentServicesContract.swift
//  iDocuments
//
//  Created by admin on 18/12/2022.
//

import Foundation

protocol DocumentServicesContract {
    func getDocuments(forQuery query: String,
                      page: Int,
                      completionHandler: @escaping ([Document]) -> Void,
                      errorHandler: @escaping (String) -> Void)
}
