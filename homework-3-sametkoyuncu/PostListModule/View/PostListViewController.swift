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
    // daha sonra bunun için bir helper class olsa daha iyi olur
    // çünkü amaç view'ın hiç data tutmaması
    // ama burada mecburen (tabloda göstermek için) tutuyoruz (şimdilik)
    private var items: [PostCellViewModel] = []
    
    private let cellReuseIdentifier = "postListTableViewCell"
    private let headerReuseIdentifier = "headerTableViewCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        registerCell()
        
        tableView.separatorStyle = .none
        
        viewModel.viewDelegate  = self
        viewModel.didViewLoad()
    }
}

private extension PostListViewController {
    func setupUI() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func registerCell() {
        tableView.register(.init(nibName: "PostListTableViewCell", bundle: nil), forCellReuseIdentifier: cellReuseIdentifier)
        
        tableView.register(.init(nibName: "HeaderTableViewCell", bundle: nil), forCellReuseIdentifier: headerReuseIdentifier)
    }
}

// MARK: - PostListModel Delegate Methods
extension PostListViewController: PostListViewModelViewProtocol {
    func didCellItemFetch(_ items: [PostCellViewModel]) {
        self.items = items
        DispatchQueue.main.async { [weak self] in
            self?.tableView.reloadData()
        }
    }
    
    func showEmptyView() {
        // TODO:
    }
    
    func hideEmptyView() {
        // TODO:
    }
}

// MARK: - TableView Delegate Methods
extension PostListViewController:  UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        viewModel.didClickItem(at: indexPath.row)
    }
}

// MARK: - TableView DataSource  Methods
extension PostListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        // show header
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: headerReuseIdentifier) as! HeaderTableViewCell
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier) as! PostListTableViewCell
        
        cell.titleLabel.text = items[indexPath.row - 1].title
        cell.descLabel.text = items[indexPath.row - 1].desc
        
        return cell
    }
}


