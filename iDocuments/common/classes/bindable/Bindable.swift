//
//  Bindable.swift
//  iDocuments
//
//  Created by admin on 18/12/2022.
//

import Foundation

class Bindable<T> {
    // MARK: - properties

    var value: T? {
        didSet {
            observer?(value)
        }
    }
    var observer: ((T?) -> ())?

    // MARK: - public methods

    func bind(observer: @escaping (T?) -> ()) {
        self.observer = observer
    }
}
