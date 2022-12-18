//
//  WebserviceManager.swift
//  iDocuments
//
//  Created by admin on 18/12/2022.
//

import Foundation
import Alamofire

class WebserviceManager {
    // MARK: - public methods.
    func callWebservice(webserviceUrl: String,
                        parameters: Parameters?,
                        successHandler: @escaping (Any) -> Void,
                        errorHandler: @escaping ([String: Any]) -> Void) {
        AF.request(webserviceUrl,
                   method: .get,
                   parameters: parameters)
        .validate()
        .responseData { response in
            switch response.result {
            case .success(let data):
                self.handleSuccessfulResponse(response: response,
                                              data: data,
                                              successHandler: successHandler,
                                              errorHandler: errorHandler)
            case .failure:
                self.handleFailedResponse(response: response,
                                          errorHandler: errorHandler)
            }
        }
    }
    
    // MARK: - private methods.
    private func handleSuccessfulResponse(response: AFDataResponse<Data>,
                                          data: Data,
                                          successHandler: @escaping (Any) -> Void,
                                          errorHandler: @escaping ([String: Any]) -> Void) {
        do {
            let dataAsJSON = try JSONSerialization.jsonObject(with: data)
            
            if let statusCodeFromResponse = response.response?.statusCode {
                let statusCode = StatusCode(rawValue: statusCodeFromResponse) ?? .unknown
                
                if statusCode == .success {
                    successHandler(dataAsJSON)
                } else {
                    self.handleFailedResponse(response: response,
                                              errorHandler: errorHandler)
                }
            }
        } catch {
            errorHandler([
                "description": "Oops! Something went wrong!"
            ])
        }
    }
    
    private func handleFailedResponse(response: AFDataResponse<Data>,
                                      errorHandler: @escaping ([String: Any]) -> Void) {
        var errorDescription = ""
        
        if let statusCodeFromResponse = response.response?.statusCode {
            let statusCode = StatusCode(rawValue: statusCodeFromResponse) ?? .unknown
            
            switch statusCode {
            case .unknown:
                errorDescription = "Oops! Something went wrong!"
            case .success:
                break
            case .unauthorized:
                errorDescription = "Unauthorized"
            case .badRequest:
                errorDescription = "Bad Request"
            case .forbidden:
                errorDescription = "Forbidden"
            case .notFound:
                errorDescription = "Not Found"
            case .notAcceptable:
                errorDescription = "Not Acceptable"
            }
            
            errorHandler([
                "description": errorDescription
            ])
        }
    }
}
