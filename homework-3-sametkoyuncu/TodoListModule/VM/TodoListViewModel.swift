//
//  TodoListViewModel.swift
//  homework-3-sametkoyuncu
//
//  Created by Samet Koyuncu on 21.09.2022.
//

import Foundation

protocol TodoListViewModelProtocol: AnyObject {
    func didCellItemFetch(_ items: [TodoItem])
}

class TodoListViewModel {

    private let model = TodoListModel()
    
    weak var viewDelegate: TodoListViewModelProtocol?
    
    init() {
        model.delegate = self
    }
    
    func getData() {
        model.fetchData()
    }
}
// Transform data Item to TodoItem
private extension TodoListViewModel {
    @discardableResult
    func makeViewBasedModel(_ todos: [Item]) -> [TodoItem] {
        return todos.map {
            TodoItem(id: $0.id!, title: $0.title!, content: $0.body!, isDone: $0.isDone)
        }
    }
}

// MARK: - TodoListModel Delegate Methods
extension TodoListViewModel: TodoListModelProtocol {
    func didDataFetchProcessFinish(_ isSuccess: Bool) {
        if isSuccess {
            let todoList = model.todoList
            let cellModels = makeViewBasedModel(todoList)
            
            
            viewDelegate?.didCellItemFetch(cellModels)
        } else {
            print("error")
        }
    }
}
