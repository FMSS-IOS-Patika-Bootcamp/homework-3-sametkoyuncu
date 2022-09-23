//
//  TodoDetailsViewController.swift
//  homework-3-sametkoyuncu
//
//  Created by Samet Koyuncu on 20.09.2022.
//

import UIKit
import SwiftUI

protocol TodoDetailsProtocol {
    func didUpdatedTodo(_ isUpdated: Bool)
    func didRemovedTodo(_ isRemoved: Bool)
}

class TodoDetailsViewController: UIViewController {
    var todoItem: TodoItem?
    
    var delegate: TodoDetailsProtocol?
    
    private let viewModel = TodoDetailsViewModel()
    
    // outlets
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var modalView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        viewModel.viewDelegate = self
    }
    
    func setupUI() {
        modalView.layer.cornerRadius = 20
        doneButton.layer.cornerRadius = doneButton.frame.height / 2
        
        titleLabel.text = todoItem?.title
        contentLabel.text = todoItem?.content
        
        if todoItem!.isDone {
            makeUncheckedButton()
        }
    }
    
    func makeUncheckedButton() {
        doneButton.setImage(UIImage(named: "unchecked"), for: .normal)
        doneButton.setTitle("Tamamlanmadı", for: .normal)
        doneButton.tintColor = .black
        doneButton.backgroundColor = UIColor(named: "themePink")
    }

    @IBAction func closeButtonPressed(_ sender: UIButton) {
        dismiss(animated: true)
    }
    
    @IBAction func doneButtonPressed(_ sender: UIButton) {
        // TODO: update attribute
        viewModel.didUpdateButtonPressed(by: todoItem!.id)
        
    }
    
    @IBAction func removeButtonPressed(_ sender: UIButton) {
        viewModel.didRemoveButtonPressed(by: todoItem!.id)
    }
}

// MARK: - TodoDetailsViewModel Delegate Methods
extension TodoDetailsViewController: TodoDetailsViewModelProtocol {
    func didItemRemove(_ isSuccess: Bool) {
        if isSuccess {
            delegate!.didRemovedTodo(true)
            dismiss(animated: true)
        } else {
            delegate!.didRemovedTodo(false)
        }
    }
    
    func didItemUpdate(_ isSuccess: Bool) {
        if isSuccess {
            delegate!.didUpdatedTodo(true)
            dismiss(animated: true)
        } else {
            delegate!.didUpdatedTodo(false)
        }
    }
    
    
}
