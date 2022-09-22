//
//  TodoDetailsModel.swift
//  homework-3-sametkoyuncu
//
//  Created by Samet Koyuncu on 22.09.2022.
//
import CoreData
import Foundation

protocol TodoDetailsModelProtocol: AnyObject {
    func didDataUpdateProcessFinish(_ isSuccess: Bool)
}

class TodoDetailsModel {
    weak var delegate: TodoDetailsModelProtocol?
    
    func updateData(id: UUID) {
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        let predicate = NSPredicate(format: "(id = %@)", id as CVarArg)
        
        fetchRequest.predicate = predicate
        
        do {
            let context = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
            let result = try context.fetch(fetchRequest).first
            
            let isDone = result?.isDone
            
            result?.setValue(!isDone!, forKey: #keyPath(Item.isDone))
            
            AppDelegate.sharedAppDelegate.coreDataStack.saveContext()
            // daha burası kullanılmıyor - view model yok :)
            delegate?.didDataUpdateProcessFinish(true)
        } catch {
            delegate?.didDataUpdateProcessFinish(false)
            print(error.localizedDescription)
        }
    }
}
