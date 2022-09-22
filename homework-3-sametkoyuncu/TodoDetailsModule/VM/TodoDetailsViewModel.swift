//
//  TodoDetailsViewModel.swift
//  homework-3-sametkoyuncu
//
//  Created by Samet Koyuncu on 22.09.2022.
//

import Foundation

protocol TodoDetailsViewModelProtocol {
    func didItemUpdate(_ isSuccess: Bool)
    func didItemRemove(_ isSuccess: Bool)
}

class TodoDetailsViewModel {
    private let model = TodoDetailsModel()
    // burada weak'e kızıyor ??
    var viewDelegate: TodoDetailsViewModelProtocol?
    
    init() {
        model.delegate = self
    }
    
    func didUpdateButtonPressed(by id: UUID) {
        model.updateData(by: id)
    }
    
    func didRemoveButtonPressed(by id: UUID) {
        model.removeData(by: id)
    }
}

extension TodoDetailsViewModel: TodoDetailsModelProtocol {
    func didDataRemoveProcessFinish(_ isSuccess: Bool) {
        if isSuccess {
            viewDelegate?.didItemRemove(true)
        } else {
            viewDelegate?.didItemRemove(false)
        }
    }
    
    func didDataUpdateProcessFinish(_ isSuccess: Bool) {
        if isSuccess {
            viewDelegate?.didItemUpdate(true)
        } else {
            viewDelegate?.didItemUpdate(false)
        }
    }
}
