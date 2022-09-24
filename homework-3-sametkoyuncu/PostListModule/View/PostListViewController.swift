//
//  ViewController.swift
//  homework-3-sametkoyuncu
//
//  Created by Samet Koyuncu on 19.09.2022.
//

import UIKit

class PostListViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private let viewModel = PostListViewModel()
    
    private let cellReuseIdentifier = "postListTableViewCell"
    private let headerReuseIdentifier = "headerTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerCell()
        
        viewModel.viewDelegate  = self
        viewModel.didViewLoad()
    }
}

private extension PostListViewController {
    func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.separatorStyle = .none
    }
    
    func registerCell() {
        tableView.register(.init(nibName: "PostListTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        
        tableView.register(.init(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: headerReuseIdentifier)
    }
}

// MARK: - TableView Delegate Methods
extension PostListViewController:  UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO:
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.didClickItem(at: indexPath.row - 1)
    }
}

// MARK: - TableView DataSource  Methods
extension PostListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.NumberOfItems() + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // show header cell
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: headerReuseIdentifier) as! HeaderTableViewCell
            return cell
        }
        // show post cell
        let cellModel = viewModel.getModel(at: indexPath.row - 1)
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! PostListTableViewCell
        
        cell.titleLabel.text = cellModel.title
        cell.descLabel.text = cellModel.desc
        
        return cell
    }
    // arkaplan görselinin gözükmesi için, arkaplanı temizle
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
}


// MARK: - PostListModel Delegate Methods
extension PostListViewController: PostListViewModelViewProtocol {
    func didCellItemFetch(isSuccess: Bool) {
        if isSuccess {
            DispatchQueue.main.async { [weak self] in
                self?.tableView.reloadData()
            }
        }
    }
    
    func showEmptyView() {
        // TODO:
    }
    
    func hideEmptyView() {
        // TODO:
    }
}


