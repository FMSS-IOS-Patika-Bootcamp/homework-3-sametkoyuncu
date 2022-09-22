//
//  AddNewItemViewController.swift
//  homework-3-sametkoyuncu
//
//  Created by Samet Koyuncu on 20.09.2022.
//

import UIKit
// protocol for update 'TodoList screen' data
protocol AddTodoItemProtocol {
    func didAddedTodoItem(_ isAdded: Bool)
}

class AddNewItemViewController: UIViewController {
    var delegate: AddTodoItemProtocol?
    private let viewModel = AddNewItemViewModel()
    
    // Outlets
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var detailsTextView: UITextView!
    @IBOutlet weak var modalView: UIView!
    @IBOutlet weak var saveButton: UIButton!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        viewModel.viewDelegate = self
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
        
        if titleTextField.text!.isEmpty {
            titleTextField.backgroundColor = UIColor(red: 1.0, green: 0.0, blue: 0.0, alpha: 0.1)
            titleTextField.placeholder = "Required field"
            return
        }
        
        guard let itemTitle = titleTextField.text else { return }
        guard let itemDetails = detailsTextView.text else { return }
        
        viewModel.didSaveButtonPressed(title: itemTitle, details: itemDetails)
        
    }
    
}

// MARK: - AddNewItemViewModel Delegate Methods
extension AddNewItemViewController: AddNewItemViewModelProtocol {
    func didItemAdd(_ isSuccess: Bool) {
        if isSuccess {
            // anasayfadaki listeyi güncellemek için
            delegate?.didAddedTodoItem(true)
            
            dismiss(animated: true)
        }
    }
    
    
}
