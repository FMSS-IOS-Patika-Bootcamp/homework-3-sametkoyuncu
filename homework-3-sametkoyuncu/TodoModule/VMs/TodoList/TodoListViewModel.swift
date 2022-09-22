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

class TodoListViewModel: TodoListModelProtocol {
    func didDataFetchProcessFinish(_ isSuccess: Bool) {
        if isSuccess {
            let todoList = model.todoList
            let cellModels = makeViewBasedModel(todoList)
            
            
            viewDelegate?.didCellItemFetch(cellModels)
        } else {
            print("error")
        }
    }
    
    private let model = TodoListModel()
    
    weak var viewDelegate: TodoListViewModelProtocol?
    
    init() {
        model.delegate = self
    }
    
    func didViewLoad() {
        model.fetchData()
    }
}

private extension TodoListViewModel {
    @discardableResult
    func makeViewBasedModel(_ todos: [Item]) -> [TodoItem] {
        return todos.map {
            TodoItem(title: $0.title!, content: $0.body!, isDone: $0.isDone)
        }
    }
}
