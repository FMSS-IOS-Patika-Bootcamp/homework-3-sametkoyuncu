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
}

class TodoDetailsViewController: UIViewController {
    var todoItem: TodoItem?
    var delegate: TodoDetailsProtocol?
    
    var model = TodoDetailsModel()
    
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    @IBOutlet weak var modalView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        model.delegate = self
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
        model.updateData(id: todoItem!.id)
      
    }
}

extension TodoDetailsViewController: TodoDetailsModelProtocol {
    func didDataUpdateProcessFinish(_ isSuccess: Bool) {
        if isSuccess {
            delegate!.didUpdatedTodo(true)
            dismiss(animated: true)
        }
    }
}
