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
    
    private let todoListCellReuseIdentifier = "TodoListTableViewCell"
    private let headerCellReuseIdentifier = "TodoHeaderTableViewCell"
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        setupUI()
        
        makeNewItemButton()
        
        viewModel.viewDelegate  = self
        viewModel.didViewLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        getData()
    }
    
    func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
    }
    
    
    func registerCells() {
        
        tableView.register(.init(nibName: "TodoListTableViewCell", bundle: nil), forCellReuseIdentifier: todoListCellReuseIdentifier)
        //tableView.register(.init(nibName: "TodoHeaderTableViewCell", bundle: nil), forCellReuseIdentifier: headerCellReuseIdentifier)
    }
    
    func makeNewItemButton() {
        let button = UIButton()
        button.setImage(UIImage(named: "add"), for: .normal)
        
        let x = view.frame.width - 70
        let y = view.frame.height - (view.frame.height / 5.5)
        button.frame = CGRect(x: x, y: y, width: 48, height: 48)
        
        button.addTarget(self, action: #selector(addItemButtonPressed), for: .touchUpInside)
        
        view.addSubview(button)
    }
    
    @objc func addItemButtonPressed() {
        let destnationVC = storyboard?.instantiateViewController(withIdentifier: "AddNewItemScreen") as! AddNewItemViewController
        
        destnationVC.delegate = self
        
        present(destnationVC, animated: true)
    }
    
    private func getData() {
        let fetchRequest: NSFetchRequest<Item> = Item.fetchRequest()
        let sortByDate = NSSortDescriptor(key: #keyPath(Item.date), ascending: false)
        
        fetchRequest.sortDescriptors = [sortByDate]
        
        do {
            let context = AppDelegate.sharedAppDelegate.coreDataStack.managedContext
            let results = try context.fetch(fetchRequest)
            todoList = results.map {
                TodoItem(id: $0.id! ,title: $0.title!, content: $0.body!, isDone: $0.isDone)
            }
            tableView.reloadData()
        } catch {
            print(error.localizedDescription)
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

// MARK: - ViewModel Methods
extension TodoListViewController: TodoListViewModelProtocol {
    func didCellItemFetch(_ items: [TodoItem]) {
        todoList = items
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

// MARK: - TableView Delegate Methods
extension TodoListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "TodoDetailsScreen") as! TodoDetailsViewController
        destinationVC.delegate = self
        destinationVC.todoItem = todoList[indexPath.row]
        
        present(destinationVC, animated: true)
    }
}

// MARK: - TableView DataSource Methods
extension TodoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        /*
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: headerCellReuseIdentifier) as! TodoHeaderTableViewCell
            
            return cell
        }*/
        
        let cell = tableView.dequeueReusableCell(withIdentifier: todoListCellReuseIdentifier) as! TodoListTableViewCell
        
        cell.titleLabel.text = todoList[indexPath.row].title
        
        cell.checkMarkImage.image = UIImage(named: todoList[indexPath.row].isDone ? "checked" : "unchecked")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
}


