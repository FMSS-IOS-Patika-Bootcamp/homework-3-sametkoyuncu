//
//  AddNewItemViewModel.swift
//  homework-3-sametkoyuncu
//
//  Created by Samet Koyuncu on 21.09.2022.
//

import Foundation

protocol AddNewItemViewModelProtocol: AnyObject {
    func didItemAdd(_ isSuccess: Bool)
}

class AddNewItemViewModel {
    private let model = AddNewItemModel()
    weak var viewDelegate: AddNewItemViewModelProtocol?
    
    init() {
        model.delegate = self
    }
    
    func didSaveButtonPressed(title: String, details: String) {
        model.addItem(title: title, details: details)
    }
}

extension AddNewItemViewModel: AddNewItemModelProtocol {
    func didDataAddProcessFinish(_ isSuccess: Bool) {
        viewDelegate?.didItemAdd(true)
    }
}
