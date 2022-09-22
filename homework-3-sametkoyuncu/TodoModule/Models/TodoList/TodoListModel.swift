//
//  TodoListModel.swift
//  homework-3-sametkoyuncu
//
//  Created by Samet Koyuncu on 21.09.2022.
//

import Foundation
import CoreData

protocol TodoListModelProtocol: AnyObject {
    func didDataFetchProcessFinish(_ isSuccess: Bool)
}

class TodoListModel {
    weak var delegate: TodoListModelProtocol?
    
    var todoList: [Item] = []
    
    func fetchData() {
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        let sortByDate = NSSortDescriptor(key: #keyPath(Item.date), ascending: false)
        
        fetchRequest.sortDescriptors = [sortByDate]
        
        do {
            let context = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
            let results = try context.fetch(fetchRequest)
            todoList = results
            delegate?.didDataFetchProcessFinish(true)
            //tableView.reloadData()
        } catch {
            delegate?.didDataFetchProcessFinish(false)
            print(error.localizedDescription)
        }
    }
}
