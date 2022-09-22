//
//  TodoListViewController.swift
//  homework-3-sametkoyuncu
//
//  Created by Samet Koyuncu on 20.09.2022.
//

import UIKit
import CoreData

class TodoListViewController: UIViewController {
    private var todoList: [TodoItem] = []
    private let viewModel = TodoListViewModel()
    
    // cell identifiers
    private let todoListCellReuseIdentifier = "TodoListTableViewCell"
    private let headerCellReuseIdentifier = "HeaderTodoListTableViewCell"
    
    // outlets
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        setupUI()
        
        // view model setup
        viewModel.viewDelegate  = self
        
        getData()
    }
    
    func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        makeNewItemButton()
    }
    
    
    func registerCells() {
        tableView.register(.init(nibName: "TodoListTableViewCell", bundle: nil), forCellReuseIdentifier: todoListCellReuseIdentifier)
        tableView.register(.init(nibName: "HeaderTodoListTableViewCell", bundle: nil), forCellReuseIdentifier: headerCellReuseIdentifier)
    }
    
    // create add button
    func makeNewItemButton() {
        let button = UIButton()
        button.setImage(UIImage(named: "add"), for: .normal)
        
        let x = view.frame.width - 70
        let y = view.frame.height - (view.frame.height / 5.5)
        button.frame = CGRect(x: x, y: y, width: 48, height: 48)
        
        button.addTarget(self, action: #selector(addItemButtonPressed), for: .touchUpInside)
        
        view.addSubview(button)
    }
    
    // add button action
    @objc func addItemButtonPressed() {
        let destnationVC = storyboard?.instantiateViewController(withIdentifier: "AddNewItemScreen") as! AddNewItemViewController
        
        destnationVC.delegate = self
        
        present(destnationVC, animated: true)
    }
    
    // get data from core data
    private func getData() {
        viewModel.getData()
    }

}

// MARK: - ViewModel Methods
extension TodoListViewController: TodoListViewModelProtocol {
    func didCellItemFetch(_ items: [TodoItem]) {
        todoList = items
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

// MARK: - AddTodoItem Methods
extension TodoListViewController: AddTodoItemProtocol {
    func didAddedTodoItem(_ isAdded: Bool) {
        if isAdded {
            getData()
        }
    }
}

// MARK: - TodoDetails Methods
extension TodoListViewController: TodoDetailsProtocol {
    func didUpdatedTodo(_ isUpdated: Bool) {
        if isUpdated {
            getData()
        }
    }
}

// MARK: - TableView Delegate Methods
extension TodoListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "TodoDetailsScreen") as! TodoDetailsViewController
        destinationVC.delegate = self
        destinationVC.todoItem = todoList[indexPath.row - 1]
        
        present(destinationVC, animated: true)
    }
}

// MARK: - TableView DataSource Methods
extension TodoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // todolist.count + header cell
        return todoList.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // custom header cell
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: headerCellReuseIdentifier) as! HeaderTodoListTableViewCell
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: todoListCellReuseIdentifier) as! TodoListTableViewCell
        
        cell.titleLabel.text = todoList[indexPath.row - 1].title
        
        cell.checkMarkImage.image = UIImage(named: todoList[indexPath.row - 1].isDone ? "checked-1" : "unchecked-1")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
}

