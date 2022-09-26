//
//  TodoListViewController.swift
//  homework-3-sametkoyuncu
//
//  Created by Samet Koyuncu on 20.09.2022.
//

import UIKit
import CoreData

class TodoListViewController: UIViewController {
    private let viewModel = TodoListViewModel()
    
    // cell identifiers
    private let todoListCellReuseIdentifier = "TodoListTableViewCell"
    private let headerCellReuseIdentifier = "HeaderTodoListTableViewCell"
    
    // outlets
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var alertView: UIView!
    @IBOutlet weak var alertCloseButton: UITableView!
    @IBOutlet weak var alertLabelText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        registerCells()
        setupUI()
        
        // view model setup
        viewModel.viewDelegate  = self
        
        getData()
    }
    
    @IBAction func alertCloseButtonPressed(_ sender: UIButton) {
        alertView.layer.isHidden = true
    }

}

// MARK: - TodoListViewController Methods
extension TodoListViewController {
    // viewDidLoad içi
    func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        
        alertView.isHidden = true
        alertView.alpha = 1.0
        
        alertView.layer.cornerRadius = 20
        
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
    
    // custom alert view
    private func showAlert(message: String) {
        alertLabelText.text = message
        alertView.isHidden = false
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            self.alertView.isHidden = true
        }
    }
}

// MARK: - ViewModel Methods - Veri geldiyse çalışacak
extension TodoListViewController: TodoListViewModelProtocol {
    func didCellItemFetch(isSuccess: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
}

// MARK: - TableView Delegate Methods - datay sayfasını tıklanan item'ı gönder
extension TodoListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        
        if indexPath.row == 0 {
            return
        }
        
        let destinationVC = storyboard?.instantiateViewController(withIdentifier: "TodoDetailsScreen") as! TodoDetailsViewController
        destinationVC.delegate = self
        destinationVC.todoItem = viewModel.getModel(at: indexPath.row - 1)
        
        present(destinationVC, animated: true)
    }
}

// MARK: - TableView DataSource Methods
extension TodoListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // todolist.count + header cell
        return viewModel.numberOfItems() + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // custom header cell
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: headerCellReuseIdentifier) as! HeaderTodoListTableViewCell
            
            return cell
        }
        
        let cellModel = viewModel.getModel(at: indexPath.row - 1)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: todoListCellReuseIdentifier) as! TodoListTableViewCell
        
        cell.titleLabel.text = cellModel.title
        
        cell.checkMarkImage.image = UIImage(named: cellModel.isDone ? "checked-1" : "unchecked-1")
        
        return cell
    }
    // tableView arkasında görsel göstermek için, arkaplanı temizliyorum
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
}


// MARK: - Item ekleme ve details sayfası açıldığında, sadece işlem gerçekleştiğinde
//         CoreData'dan veri çekilmesi için, Ekleme ve Detay sayfalarına
//         Protocol ekledim. Aşağıdaki 2 extension o işlemler için kullanılıyor.
//         Değişiklik varsa yeni veriyi çekiyor ve kullanıcıya bildirim gösteriyor.
//

// MARK: - AddTodoItem Methods
extension TodoListViewController: AddTodoItemProtocol {
    func didAddedTodoItem(_ isAdded: Bool) {
        if isAdded {
            getData()
            showAlert(message: "Item, Successfully Added!")
            
        } else {
            self.showToast(message: "Unsuccessful ❌", font: .systemFont(ofSize: 14.0, weight: .bold))
        }
    }
}

// MARK: - TodoDetails Methods
extension TodoListViewController: TodoDetailsProtocol {
    func didRemovedTodo(_ isRemoved: Bool) {
        if isRemoved {
            getData()
            showAlert(message: "Item, Successfully Removed!")
        } else {
            self.showToast(message: "Unsuccessful ❌", font: .systemFont(ofSize: 14.0, weight: .bold))
        }
    }
    
    func didUpdatedTodo(_ isUpdated: Bool) {
        if isUpdated {
            getData()
            showAlert(message: "Item, Successfully Updated!")
        } else {
            self.showToast(message: "Unsuccessful ❌", font: .systemFont(ofSize: 14.0, weight: .bold))
        }
    }
}


