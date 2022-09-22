//
//  AddNewItemViewController.swift
//  homework-3-sametkoyuncu
//
//  Created by Samet Koyuncu on 20.09.2022.
//

import UIKit

protocol AddTodoItemProtocol {
    func didAddedTodoItem(_ isAdded: Bool)
}

class AddNewItemViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var detailsTextView: UITextView!
    @IBOutlet weak var modalView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    
    var delegate: AddTodoItemProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    func setupUI() {
        modalView.layer.cornerRadius = 20
        
        detailsTextView.layer.cornerRadius = 5
        detailsTextView.layer.borderWidth = 1
        detailsTextView.layer.borderColor = CGColor(red: 0.0, green: 0.0, blue: 0.0, alpha: 0.05)
        
        saveButton.layer.cornerRadius = saveButton.frame.height / 2
    }
 
    @IBAction func closeScreen(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func saveButtonPressed(_ sender: UIButton) {
        print("save basıldı")
        let managedContext = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
        
        guard let itemTitle = titleTextField.text else { return }
        guard let itemDetails = detailsTextView.text else { return }
        
        let data = Item(context: managedContext)
        data.setValue(UUID(), forKey: "id")
        data.setValue(itemTitle, forKey: #keyPath(Item.title))
        data.setValue(itemDetails, forKey: #keyPath(Item.body))
        data.setValue(Date(), forKey: #keyPath(Item.date))
        
        AppDelegate.sharedAppDelegate.coreDataStack.saveContext()
        
        // TODO: docatch gerek
        delegate?.didAddedTodoItem(true)
        
        dismiss(animated: true)
    }
    
}
