//
//  AddNewItemModel.swift
//  homework-3-sametkoyuncu
//
//  Created by Samet Koyuncu on 22.09.2022.
//

import Foundation
import CoreData

protocol AddNewItemModelProtocol: AnyObject {
    func didDataAddProcessFinish(_ isSuccess: Bool)
}


class AddNewItemModel {
    weak var delegate: AddNewItemModelProtocol?
    
    func addItem(title: String, details: String) {
        let managedContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
        
        let data = Item(context: managedContext)
        data.setValue(UUID(), forKey: "id")
        data.setValue(title, forKey: #keyPath(Item.title))
        data.setValue(details, forKey: #keyPath(Item.body))
        data.setValue(Date(), forKey: #keyPath(Item.date))
        AppDelegate.sharedAppDelegate.coreDataStack.saveContext()
        
        delegate?.didDataAddProcessFinish(true)
        
    }
}
