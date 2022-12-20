//
//  DictionaryExtension.swift
//  iDocuments
//
//  Created by admin on 20/12/2022.
//

import CommonCrypto
import Foundation

extension Dictionary {
    func getString(_ key: Key, defaultValue: String = "") -> String {
        if let value = self[key] as? String {
            return value
        }
        
        return defaultValue
    }
    
    func getArray(_ key: Key, defaultValue: [Any] = []) -> [Any] {
        if let value = self[key] as? [Any] {
            return value
        }
        
        return defaultValue
    }
}
