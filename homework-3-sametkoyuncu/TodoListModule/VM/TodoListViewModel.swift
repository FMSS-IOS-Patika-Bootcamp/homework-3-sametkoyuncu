//
//  TodoListViewModel.swift
//  homework-3-sametkoyuncu
//
//  Created by Samet Koyuncu on 21.09.2022.
//

import Foundation
// burası uçacak gibi
protocol TodoListViewModelProtocol: AnyObject {
    func didCellItemFetch(isSuccess: Bool)
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
    
    func numberOfItems() -> Int {
        return model.todoList.count
    }

    func getModel(at index: Int) -> TodoItem {
        let item =  model.todoList[index]
        
        return transformItemToTodoItem(from: item)
    }
    
    private func transformItemToTodoItem(from item: Item) -> TodoItem {
        return TodoItem(id: item.id!, title: item.title!, content: item.body!, isDone: item.isDone)
    }
}

// MARK: - TodoListModel Delegate Methods
extension TodoListViewModel: TodoListModelProtocol {
    func didDataFetchProcessFinish(_ isSuccess: Bool) {
        if isSuccess {
            viewDelegate?.didCellItemFetch(isSuccess: true)
        } else {
            print("error")
        }
    }
}
