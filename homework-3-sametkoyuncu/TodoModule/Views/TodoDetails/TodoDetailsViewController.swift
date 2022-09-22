//
//  TodoDetailsViewController.swift
//  homework-3-sametkoyuncu
//
//  Created by Samet Koyuncu on 20.09.2022.
//

import UIKit

class TodoDetailsViewController: UIViewController {
    
    let todoItem: TodoItem? = .init(title: "Markete git", content: "Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet. Lorem ipsum dolor sit amet.", isDone: false)
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var contentLabel: UILabel!
    
    @IBOutlet weak var modalView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
       
        // Do any additional setup after loading the view.
    }
    
    func setupUI() {
        modalView.layer.cornerRadius = 20
        doneButton.layer.cornerRadius = doneButton.frame.height / 2
        
        titleLabel.text = todoItem?.title
        contentLabel.text = todoItem?.content
        
        if ((todoItem?.isDone) != nil) {
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
        dismiss(animated: true)
    }
}
