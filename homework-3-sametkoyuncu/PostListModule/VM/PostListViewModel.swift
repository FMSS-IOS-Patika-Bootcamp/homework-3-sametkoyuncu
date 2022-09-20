//
//  PostListViewModel.swift
//  homework-3-sametkoyuncu
//
//  Created by Samet Koyuncu on 19.09.2022.
//

import Foundation

protocol PostListViewModelViewProtocol: AnyObject {
    func didCellItemFetch(_ items: [PostCellViewModel])
    func showEmptyView()
    func hideEmptyView()
}

class PostListViewModel {
    private let model = PostListModel()
    
    weak var viewDelegate: PostListViewModelViewProtocol?
    
    init() {
        model.delegate = self
    }
    
    // view yüklendiyse data çek
    func didViewLoad() {
        model.fetchData()
    }
    
    //
    func didClickItem(at index: Int) {
        let selectedItem = model.posts[index]
        // TODO: navigate
    }
}

private extension PostListViewModel {
    
    @discardableResult
    func makeViewBasedModel(_ posts: [Post]) -> [PostCellViewModel] {
        return posts.map { .init($0.title, $0.body) }
    }
}

// MARK: - PostListModel Delegate Methods
extension PostListViewModel: PostListModelProtocol {
    func didDataFetchProcessFinish(_ isSuccess: Bool) {
        if isSuccess {
            let posts = model.posts
            let cellModels = makeViewBasedModel(posts)
            
            viewDelegate?.hideEmptyView()
            viewDelegate?.didCellItemFetch(cellModels)
        } else {
            viewDelegate?.showEmptyView()
        }
        
    }
}
