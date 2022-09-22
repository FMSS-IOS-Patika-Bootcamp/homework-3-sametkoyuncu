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
    func didDataRemoveProcessFinish(_ isSuccess: Bool)
}

class TodoDetailsModel {
    weak var delegate: TodoDetailsModelProtocol?
    
    func updateData(by id: UUID) {
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        let predicate = NSPredicate(format: "(id = %@)", id as CVarArg)
        
        fetchRequest.predicate = predicate
        
        do {
            let context = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
            let result = try context.fetch(fetchRequest).first
            
            if let result = result {
                let isDone = result.isDone
                
                result.setValue(!isDone, forKey: #keyPath(Item.isDone))
                
                AppDelegate.sharedAppDelegate.coreDataStack.saveContext()
                delegate?.didDataUpdateProcessFinish(true)
            } else {
                delegate?.didDataUpdateProcessFinish(false)
            }
            
          
        } catch {
            delegate?.didDataUpdateProcessFinish(false)
            print(error.localizedDescription)
        }
    }
    
    func removeData(by id: UUID) {
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        let predicate = NSPredicate(format: "(id = %@)", id as CVarArg)
        
        fetchRequest.predicate = predicate
        
        do {
            let context = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
            let result = try context.fetch(fetchRequest).first
            
            if let result = result {
                context.delete(result)
                AppDelegate.sharedAppDelegate.coreDataStack.saveContext()
                // daha burası kullanılmıyor - view model yok :)
                delegate?.didDataRemoveProcessFinish(true)
            } else {
                delegate?.didDataRemoveProcessFinish(true)
            }
            
            
           
        } catch {
            delegate?.didDataUpdateProcessFinish(false)
            print(error.localizedDescription)
        }
    }
    
    
    
    
    
}
