//
//  StatusCode.swift
//  iDocuments
//
//  Created by admin on 18/12/2022.
//

import Foundation

enum StatusCode: Int {
    case unknown = -1
    case success = 200
    case unauthorized = 401
    case badRequest = 400
    case forbidden = 403
    case notFound = 404
    case notAcceptable = 406
}
